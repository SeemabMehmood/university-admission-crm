Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.active_storage.service = :local

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: "www.accesseducationcrm.com" }
  config.action_mailer.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      user_name: ENV["SENDGRID_USERNAME"],
      password:  ENV["SENDGRID_PASSWORD"],
      domain:    "www.accesseducationcrm.com",
      address:   "smtp.sendgrid.net",
      port: 587,
      authentication: :plain,
      enable_starttls_auto: true
  }

  Rails.application.config.middleware.use ExceptionNotification::Rack,
  email: {
    email_prefix: "Access Education CRM Error",
    sender_address: %{"notifier" <notifier@access_education_crm.com>},
    exception_recipients: %w{seemab.mehmood25@gmail.com}
  }
end
