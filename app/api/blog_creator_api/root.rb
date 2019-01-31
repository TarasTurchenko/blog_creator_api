# frozen_string_literal: true

module BlogCreatorApi
  class Root < Grape::API
    helpers BlogCreatorApi::Shared::BaseHelpers

    format :json
    rescue_from :all

    mount BlogCreatorApi::Blogs::V1
    mount BlogCreatorApi::Posts::V1
    mount BlogCreatorApi::Containers::V1

    add_swagger_documentation mount_path: '/swagger_doc'
  end
end