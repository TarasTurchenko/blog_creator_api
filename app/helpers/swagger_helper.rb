module SwaggerHelper
  def swagger_asset_path(filename)
    "#{ENV['CLOUDFRONT']}/swagger/#{filename}"
  end
end
