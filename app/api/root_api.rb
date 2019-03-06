# frozen_string_literal: true

class RootApi < Grape::API
  format :json
  rescue_from :all

  helpers SharedApi::Helpers::Common
  helpers SharedApi::Helpers::ErrorResponses
  helpers SharedApi::Helpers::Auth

  mount MainApi::ApiV1

  add_swagger_documentation mount_path: '/swagger_doc'
end
