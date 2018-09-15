Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Rails.application.config.assets.precompile += %w( index.js )

# Rails.application.config.assets.paths << Rails.root.join('/vendor/assets')
Rails.application.config.assets.paths << Rails.root.join('/app/assets/fonts')
Rails.application.config.assets.precompile += %w( foundation_emails.css )
