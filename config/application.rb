require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiTest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # config.api_only = true
    config.autoload_paths << Rails.root.join('app', 'uploaders')

    config.autoload_paths += %W(#{config.root}/lib)
    if ENV['RAILS_ENV'] == 'test'
       system('prmd combine --meta docs/schema/meta.yml docs/schema/schemata/yml > docs/schema/schema.json')
       str = File.read("#{Rails.root}/docs/schema/schema.json")
       schema = JSON.parse(str)

       config.middleware.use Rack::JsonSchema::Docs, schema: schema
       config.middleware.use Rack::JsonSchema::SchemaProvider, schema: schema
       config.middleware.use Rack::JsonSchema::ErrorHandler
      # config.middleware.use Rack::JsonSchema::RequestValidation, schema: schema
       config.middleware.use Rack::JsonSchema::ResponseValidation, schema: schema
      #  config.middleware.use Rack::JsonSchema::Mock, schema: schema
    end

  end
end
