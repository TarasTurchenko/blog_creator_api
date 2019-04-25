# frozen_string_literal: true

class RootApi < BaseApi
  format :json
  helpers ApiHelpers::CommonHelpers

  mount ApiRedirect::ApiV1

  rescue_from :all

  helpers ApiHelpers::ErrorResponses
  helpers ApiHelpers::AuthHelpers
  helpers ApiHelpers::BlogHelpers

  mount ApiMain::ApiV1

  add_swagger_documentation(mount_path: '/swagger_doc')
end
