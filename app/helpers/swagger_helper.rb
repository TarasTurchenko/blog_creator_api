# frozen_string_literal: true

module SwaggerHelper
  def swagger_asset_path
    Helpers::Aws.build_cdn_url("swagger")
  end
end
