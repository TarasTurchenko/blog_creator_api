# frozen_string_literal: true

module AssetsHelper
  def published_asset_path(asset)
    asset_relative_path = Rails.env.development? ? asset : "app/#{asset}"
    Helpers.build_server_path("assets/#{asset_relative_path}")
  end
end