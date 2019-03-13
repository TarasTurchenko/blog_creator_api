# frozen_string_literal: true

class RootApi < Grape::API
  format :json
  rescue_from :all

  helpers ApiHelpers::CommonHelpers
  helpers ApiHelpers::ErrorResponses
  helpers ApiHelpers::AuthHelpers
  helpers ApiHelpers::BlogHelpers

  mount ApiMain::ApiV1

  add_swagger_documentation mount_path: '/swagger_doc'
end
