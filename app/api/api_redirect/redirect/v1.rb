# frozen_string_literal: true

module ApiRedirect
  module Redirect
    class V1 < BaseApi
      resource :redirect do
        get do
          request.url
        end
      end
    end
  end
end