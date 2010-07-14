class ActivitiesController < ApplicationController
  before_filter :login_or_oauth_required, :except => [:index, :new, :create, :show_from_permalink]
  
  def index
    if logged_in?
      @activities = current_user.activities
    else
      @activities = (session[:activities] || []).map { |a| Activity.find(a) rescue nil }.compact
    end
  end

  def show
    @activity = find_from_session_or_user(params[:id])
  end
  
  def show_from_permalink
    @activity = Activity.find_by_permalink(params[:id])
    render :action => 'show'
  end
  
  def new
    @activity = Activity.new
  end
  
  def create
    @activity = Activity.new(params[:activity])
    @activity.user = current_user

    if @activity.save
      unless logged_in?
        session[:activities] ||= []
        session[:activities] << @activity.id
      end

      flash[:notice] = "Successfully created activity."
      redirect_to @activity
    else
      render :action => 'new'
    end
  end
  
  def edit
    @activity = find_from_session_or_user(params[:id])
  end
  
  def update
    @activity = find_from_session_or_user(params[:id])
    @activity.user = current_user

    if @activity.update_attributes(params[:activity])
      flash[:notice] = "Successfully updated activity."
      redirect_to @activity
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @activity = find_from_session_or_user(params[:id])
    @activity.destroy
    flash[:notice] = "Successfully destroyed activity."
    redirect_to activities_url
  end

  private
  def find_from_session_or_user(id)
    # if the user is logged in, find from owned activities...
    if logged_in?
      current_user.activities.find(id)

    # ... otherwhise, search for the activity id on the session
    else
      if session[:activities].find(id.to_i).present?
        Activity.find(params[:id])
      else
        # everything fails, so give back 404
        raise ActiveRecord::RecordNotfound
      end
    end
  end
end
