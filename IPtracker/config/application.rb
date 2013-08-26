require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module IPtracker
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Enable the asset pipeline
  
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.assets.paths << "#{Rails.root}/public/layouts"
    

    #Windows
    if RUBY_PLATFORM =~ /mswin/ || RUBY_PLATFORM =~ /mingw/
      config.imageMagickPath = "#{Rails.root}/../ImageMagick/"
    #Linux
    else
      config.imageMagickPath = ""
    end
    
    config.paperclip_defaults = {:storage => :fog, :fog_credentials => {:provider => "Local", :local_root => "#{Rails.root}/public"}, :fog_directory => "", :fog_host => "localhost"}  
  
    #Silicon Releases must match this expression
    config.silicon_regex = /\A\d{4}[A-z]{2}\z/
  end
end