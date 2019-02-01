# frozen_string_literal: true

module MainApi
  class Root < Grape::API
    helpers SharedApi::BaseHelpers

    format :json
    rescue_from :all

    mount Blogs::V1
    mount Posts::V1
    mount Containers::V1

    add_swagger_documentation mount_path: '/swagger_doc'
  end
end