class WelcomeController < ApplicationController
    # A controller's public methods are called "actions".
    # Actions will handle requests from the user, render
    # a response and reply with it.
  
    def index
      # Use the `render` method inside a controller action
      # to build the content of a response. Using
      # it with the "plain" named arg. will just render
      # plain text.
      # render(plain: "Hello, World!")
  
      # If you name your views after the controller's action,
      # you can omit the render. Rails will always look
      # for a file named after the action in a sub-directory
      # of views/ named after the controller even you do
      # not call `render`.
      # render :index
    end
  end