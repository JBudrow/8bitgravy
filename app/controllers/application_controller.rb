class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  protected
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def authenticate
      unless current_user
        redirect_to new_user_path,
        # redirect_to new_session_url,
          alert: 'You need to sign in or sign up before continuing'
      end
    end
end
