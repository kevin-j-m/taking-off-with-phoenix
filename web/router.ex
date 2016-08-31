defmodule Workshop.Router do
  use Workshop.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Workshop.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Workshop do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    delete "/logout", SessionController, :delete
    get "/login", SessionController, :new
    post "/login", SessionController, :create

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", Workshop do
  #   pipe_through :api
  # end
end
