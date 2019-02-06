module SwaggerHelper
  def swagger_asset_path
    "#{ENV['CDN_URL']}/swagger"
  end
end
