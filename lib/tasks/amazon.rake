# frozen_string_literal: true

namespace :amazon do
  ASSETS = %w[post.css].freeze
  ASSETS_DIR = 'assets/app'

  task upload_assets: 'assets:precompile' do
    assets = Sprockets::Railtie.build_environment(Rails.application, true)
    ASSETS.each do |asset|
      source = assets['post.css'].to_s
      path = "#{ASSETS_DIR}/#{asset}"
      Helpers::Aws.upload_to_storage path, source
    end
    Rake::Task['amazon:reset_cdn_caches'].invoke
  end

  task :reset_cdn_caches do
    key = Digest::SHA1.hexdigest "reset assets #{DateTime.now}"
    items = ["/#{ASSETS_DIR}/*"]
    Helpers::Aws.invalidate_cdn_paths key, items
  end
end