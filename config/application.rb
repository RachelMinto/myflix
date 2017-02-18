require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end

    config.autoload_paths << "#{Rails.root}/lib"
  end
end

Raven.configure do |config|
  config.dsn = 'https://3f4046a0a4b14ef9841b2ecdea9220ae:863abe5582ac40209c616996f0ba245a@sentry.io/140350'
  config.environments = ['production']
end