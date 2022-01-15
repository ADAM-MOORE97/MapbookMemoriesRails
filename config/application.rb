require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MapbookMemoriesRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
 

    # Configuration for the application, engines, and railties goes here.
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.action_dispatch.cookies_same_site_protection = :strict
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.load_defaults 7.0
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = false
  end
end
