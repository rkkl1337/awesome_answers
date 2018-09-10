Rails.application.routes.draw do

  # `resource` is singular instead of `resources`.
  # Unlike `resources`, it creates routes that do CRUD
  # one thing and instead of a collection of things.
  # This means that the "index" doesn't exist and none
  # of the routes require an "id" and all of their names
  # are singular. The controller MUST STILL BE plural.
  
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  # Routes for Questions Controller
  resources :questions do
    # The `shallow`, when set to `true`, will only nest the routes
    # for certain CRUD actions.
    # - `index` & `create` will be nested
    # - `show`, `edit`, `update` and `destroy` will not be nested
    resources :answers, shallow: true, only: [:create, :destroy, :edit, :update]
  end
  # Use the `resources` method to reproduce all CRUD routes in one
  # go. This will create all routes that commented below:

  # get "/questions/new", to: "questions#new", as: :new_question
  # post "/questions", to: "questions#create"
  # get "/questions", to: "questions#index"
  # get "/questions/:id", to: "questions#show", as: :question
  # delete "/questions/:id", to: "questions#destroy"
  # get "/questions/:id/edit", to: "questions#edit", as: :edit_question
  # patch "/questions/:id", to: "questions#update"
  # put "/questions/:id", to: "questions#update"

  # Useful shell trick to filter displayed routes with `rails routes`:
  # `rails routes | grep question`
  # The above filter all routes for those that contain
  # the word "question"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # To create a route, use any of the methods offered
  # by rails that are named after all available
  # HTTP methods (e.g. get, post, put, patch, delete, etc)

  # As a first argument, write a URL path as a string.
  # Then, provide the named argument "to" with string that
  # gives the location of an action in a controller.

  # Example: `to: "welcome#index"` directs the request
  # to the action named "index" in the "WelcomeController"
  get("/", to: "welcome#index", as: :root)

  # Routes will create methods useable in your controllers
  # and views that will return the URL or URL path
  # to a route. This is tremendously useful when creating links.

  # The name of these will generate from the first argument
  # otherwise will use the named arg. `as`'s value.

  # The get above will create:
  # - root_path -> "/"
  # - root_url -> "http://localhost:3000/"

  # To view all routes available in your application,
  # run the following command in terminal:
  # `rails routes`

  get("/contact", to: "contact#index")
  # Methods provided: `contact_path` and `contact_url`
  post("/contact/submit", to: "contact#submit")
end