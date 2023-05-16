defmodule CarsWeb.Router do
  use CarsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CarsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CarsWeb do
    pipe_through :browser

    get "/", PageController, :home

    resources "/cars", CarController
    # get "/cars", CarController, only: [:index, :show]
    # get "/cars/:id", CarController, :show
    # get "/cars/new", CarController, :new
    # post "/cars", CarController, :create
    # <--- post method
    post "/cars-import", CarController, :import
  end

  # Other scopes may use custom stacks.
  # scope "/api", CarsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:cars, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CarsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
