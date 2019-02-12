# frozen_string_literal: true

class RootApi < Grape::API
  helpers SharedApi::BaseHelpers

  format :json
  rescue_from :all

  mount MainApi::Blogs::V1
  mount MainApi::Posts::V1
  mount MainApi::Containers::V1
  mount MainApi::Elements::V1

  mount MainApi::Images::V1

  add_swagger_documentation mount_path: '/swagger_doc'
end
