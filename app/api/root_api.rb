# frozen_string_literal: true

class RootApi < Grape::API
  format :json
  rescue_from :all

  helpers ApiHelpers::Common
  helpers ApiHelpers::ErrorResponses
  helpers ApiHelpers::Auth
  helpers ApiHelpers::Blog

  mount ApiMain::ApiV1

  add_swagger_documentation mount_path: '/swagger_doc'
end
