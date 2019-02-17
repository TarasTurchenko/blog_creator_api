# frozen_string_literal: true

module AssetsHelper
  def published_asset_path(asset)
    return "#{ENV['DEV_APP_URL']}/assets/#{asset}" if Rails.env.development?

    Helpers::Aws.build_cdn_url("assets/app/#{asset}")
  end
end