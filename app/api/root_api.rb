# frozen_string_literal: true

class RootApi < Grape::API
  format :json
  rescue_from :all

  helpers ApiShared::Helpers::Common
  helpers ApiShared::Helpers::ErrorResponses
  helpers ApiShared::Helpers::Auth

  mount ApiMain::ApiV1

  add_swagger_documentation mount_path: '/swagger_doc'
end
