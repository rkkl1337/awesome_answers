class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email])
  
      if user&.authenticate(params[:session][:password])
        session[:user_id] = user.id
  
        flash[:success] = "Thanks for signing in, #{user.first_name}!"
        redirect_to root_path
      else
        # The `flash` is a object like `session`, but it's very
        # temporary. It allows to a store a value for the next request
        # then it disappears. It behaves like hash and is useable
        # within controllers & views.
        flash[:danger] = "Invalid email or password"
        redirect_to new_session_path
      end
    end

    def destroy
        session[:user_id] = nil

        flash[:success] = "Successfully signed out"
        redirect_to root_path
    end
  end