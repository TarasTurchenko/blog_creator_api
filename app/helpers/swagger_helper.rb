module SwaggerHelper
  def swagger_asset_path
    "#{ENV['CLOUDFRONT']}/swagger"
  end
end
