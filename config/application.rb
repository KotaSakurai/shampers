require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shampers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.eager_load_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib"]
    config.autoload_paths += %W(#{config.root}/lib/validates)
    config.autoload_paths += %W(#{config.root}/lib/decorators)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
