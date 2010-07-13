class ActivitiesController < ApplicationController
  
  def index
    @activities = Activity.find(:all)
  end

  def show
    @activity = Activity.find(params[:id])
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
    @activity = Activity.find(params[:id])
  end
  
  def update
    @activity = Activity.find(params[:id])
    @activity.user = current_user

    if @activity.update_attributes(params[:activity])
      flash[:notice] = "Successfully updated activity."
      redirect_to @activity
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:notice] = "Successfully destroyed activity."
    redirect_to activities_url
  end
end
