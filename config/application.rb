require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Poseidon
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :zh
    config.autoload_paths += %W(
    #{config.root}/app/datatables/concerns
    #{config.root}/app/decorators/concerns
    #{config.root}/app/models/state_machines
    )

    # Don't care if the mailer can't send.
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_url_options = {host: 'localhost', port: 3000}
    config.action_mailer.smtp_settings = {
        admin_user: 'rubyfan@163.com',
        from: 'rubyfan@163.com',
        return_path: 'rubyfan@163.com',
        address: 'smtp.163.com',
        user_name: 'rubyfan@163.com',
        password: 'xxxxxxxxx'
    }
    config.active_record.raise_in_transactional_callbacks = true
  end
end
