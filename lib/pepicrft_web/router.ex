defmodule PepicrftWeb.Router do
  use PepicrftWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "xml"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PepicrftWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :xml do
    plug :accepts, ["xml"]
  end

  scope "/", PepicrftWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/about", HomeController, :about
    get "/mastodon", HomeController, :mastodon
    get "/photos", HomeController, :photos
    get "/blog/:year/:month/:day/:title", BlogController, :show

    for page <- Pepicrft.Pages.all_pages() do
      get page.slug, PageController, :show, as: page.identifier
    end
  end

  scope "/", PepicrftWeb do
    pipe_through :xml

    get "/blog/feed.xml", FeedController, :blog
  end

  # Other scopes may use custom stacks.
  # scope "/api", PepicrftWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PepicrftWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
