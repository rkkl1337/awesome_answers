class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new user_params
  
      if @user.save
        # The `session` is an object useable in controllers & views
        # that uses cookies to store encrypted data. It behaves just
        # like a hash hiding all of the nitty gritty of working with
        # encrypted cookies.
  
        # We store a `user_id` in the session to represent
        # that the user is signed in. Later, we'll be able to
        # retrieve the logged in user by the id.
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render :new
      end
    end
  
    private
    def user_params
      params
        .require(:user)
        .permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end