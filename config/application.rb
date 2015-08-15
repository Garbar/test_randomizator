require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestRandomizator
  class Application < Rails::Application
    config.active_job.queue_adapter = :delayed_job
    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.stylesheets = false
      g.javascripts = false
      g.helper      = false
    end
  end
end
