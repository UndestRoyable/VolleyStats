require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Hirb.enable
module VolleyStats
  class Application < Rails::Application
    
      config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.assets.initialize_on_precompile = false
  config.assets.enabled = true
  config.assets.precompile = ["css/bootstrap.min.css","styles.css", "select2.css", "signin.css", "match-data.css", "datepicker.css", "jquery-ui.css", "statistic.css", "filter.css", "contact-style.css", "bootstrapValidator.min.css", "application.css"]
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'volleystats.com',
    user_name:            'volleystatsbg',
    password:             'verystrong',
    authentication:       'plain',
    enable_starttls_auto: true  }


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
