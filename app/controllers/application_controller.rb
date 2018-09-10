class ApplicationController < ActionController::Base
    private
    def current_user
      if session[:user_id].present?
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end
    helper_method(:current_user)
    # `helper_method` makes a controller available to all
    # views (or templates)
  
    def user_signed_in?
      current_user.present?
    end
    helper_method(:user_signed_in?)

    def authenticate_user!
      unless user_signed_in?
        flash[:danger] = "Access Denied"
        redirect_to root_path
      end
    end
  end