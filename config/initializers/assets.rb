Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Rails.application.config.assets.precompile += %w( index.js )

Rails.application.config.assets.paths << Rails.root.join('vendor')
Rails.application.config.assets.paths << Rails.root.join('/app/assets/fonts')

# Rails.application.config.assets.precompile += %w( interface.css forms.css tables.css chart_view.css app_view.css )
# Rails.application.config.assets.precompile += %w( interface.js pages.js forms.js tables.js chart_view.js app_view.js )
