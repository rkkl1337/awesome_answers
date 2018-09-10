class ContactController < ApplicationController
    def index
    end
  
    def submit
      # In Rails, all of Express' req.params, req.query &
      # req.body are combined into `params`
  
      # Use `render json: params` as you `res.send(req.body)`
      # in Express to show data in the browser as JSON.
      # Useful learning and debugging.
      
      # render json: params

      # To use variables in templates, create them as
      # instance variables in your controller actions and
      # methods.
      @message = "Thank you for sending us a message!"
      render :index
    end
  end