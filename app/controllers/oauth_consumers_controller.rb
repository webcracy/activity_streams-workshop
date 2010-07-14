require 'oauth/controllers/consumer_controller'
class OauthConsumersController < ApplicationController
  include Oauth::Controllers::ConsumerController
  
  before_filter :load_consumer
  skip_before_filter :login_required
  
  def index
    if logged_in?
      @consumer_tokens=ConsumerToken.all :conditions=>{:user_id=>current_user.id}
      @services=OAUTH_CREDENTIALS.keys-@consumer_tokens.collect{|c| c.class.service_name}
    end
  end
  
  # This callback method is heavily modified from the plugin's original to allow session and user creation 
  # from an Aidentiti Oauth Authorization
  def callback
    @request_token_secret = session[params[:oauth_token]]
    if @request_token_secret
      if params[:id] == 'aidentiti'
        # Create an Aidentiti Oauth Consumer to grab the user's credential
        @consumer = AidentitiToken.consumer
        access_token = get_access_token(@consumer, params[:oauth_token], @request_token_secret, params[:oauth_verifier])
        # Save the Consumer's token and use it to create the client
        @token = AidentitiToken.create(:token => access_token.token, :secret => access_token.secret)
        aidentiti_client = Aidentiti::Base.new(@token.client)
        # Make the call to Aidentiti
        user_profile = aidentiti_client.grab_credentials.user
        # Do we need to create this user, or just load it?
        user = User.find_or_create_by_email(:email => user_profile.email, :login => user_profile.login)
        user.password = user.password_confirmation = user.login.reverse
        user.save

        # Transfer any activities this user created as anonymous to the new found user
        if session[:activities].present?
          session[:activities].each do |a|
            activity = Activity.find(a) rescue nil
            activity.try(:update_attribute, :user_id, user.id)
          end
          session[:activities] = []
        end

        # Create a new session
        reset_session
        self.current_user = user
        new_cookie_flag = true
        handle_remember_cookie! new_cookie_flag
        # Keep the Aidentiti Oauth Token table clean
        old_consumer = AidentitiToken.find_by_user_id(user.id).delete if AidentitiToken.find_by_user_id(user.id)
        # Wrap up by assigning the 
        @token.user_id = user.id
      # elsif params[:id] == 'yammer'
        # here you could use program specific behaviour for other oauth providers
      end
      if @token.save
        flash[:notice] = "#{params[:id].humanize} was successfully connected to your account"
        go_back
      else
        flash[:error] = "An error happened, please try connecting again"
        redirect_to oauth_consumer_url(params[:id])
      end
    end
    
  end
  
  protected
  
  # Change this to decide where you want to redirect user to after callback is finished.
  # params[:id] holds the service name so you could use this to redirect to various parts
  # of your application depending on what service you're connecting to.
  def go_back
    redirect_to root_url
  end
  
  def load_consumer
    consumer_key=params[:id].to_sym
    throw RecordNotFound unless OAUTH_CREDENTIALS.include?(consumer_key)
    @consumer="#{consumer_key.to_s.camelcase}Token".constantize
    if current_user
      @token=@consumer.find_by_user_id current_user.id
    end
  end
  
  def get_access_token(consumer, token,secret,oauth_verifier)
    request_token=OAuth::RequestToken.new consumer,token,secret
    options={}
    options[:oauth_verifier]=oauth_verifier if oauth_verifier
    access_token=request_token.get_access_token options
    access_token
  end
  
end
