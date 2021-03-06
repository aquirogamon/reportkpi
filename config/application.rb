#encoding: utf-8
require_relative 'boot'

require 'rails/all'
require 'rest-client'
require 'json'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReporteKPI
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
     config.assets.paths << "#{Rails.root}/app/assets/stylesheets/font-awesome-4.2.0/css/"
     config.assets.paths << "#{Rails.root}/app/assets/stylesheets/bootstrap/" #All bootstraps css files location
     config.assets.paths << "#{Rails.root}/vendor/assets/fonts"
     config.time_zone = "Lima"
     config.encoding = "utf-8"
  end
end
