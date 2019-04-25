# frozen_string_literal: true

module ApiRedirect
  class ApiV1 < BaseApi
    version 'v1', using: :path

    mount ApiRedirect::Redirect::V1
  end
end