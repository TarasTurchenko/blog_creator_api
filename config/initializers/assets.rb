# frozen_string_literal: true

Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')

assets_base = %w[app/assets/stylesheets/*.scss app/assets/javascripts/*.js]
assets = Dir[*assets_base].map { |path| path[%r{[^/]+.(scss|js)}] }
Rails.application.config.assets.precompile += assets
