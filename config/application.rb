require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GameCabin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.assets.initialize_on_precompile = false
    config.enable_dependency_loading = true
    config.serve_static_assets = true
    config.autoload_paths += %W[#{Rails.root}/lib]
    config.autoload_paths += Dir[
      Rails.root.join('app', 'policies', '*.rb'),
      Rails.root.join('app', 'lib', '*.rb')
  ]  
    
   
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # Reduce the file that I don't need and the size of whole folder.
    config.generators do |generator|
      generator.test_framework false
    end
  end
end
