Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.action_mailer.delivery_method = :smtp
#   config.action_mailer.default_url_options = { host: 'localhost:3000'}  
#   config.action_mailer.smtp_settings = {
#     address:              "smtp.gmail.com",
#     port:                 587,
#     domain:               "gmail.com",
#     user_name:            ENV["GMAIL_USERNAME"],
#     password:             ENV["GMAIL_PASSWORD"],
#     authentication:       'plain',
#     enable_starttls_auto: true  }  
# end  
  
  config.action_mailer.default_url_options = { host: ENV['domain']}

  ActionMailer::Base.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'],
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => ENV['domain'],
    :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp
end
