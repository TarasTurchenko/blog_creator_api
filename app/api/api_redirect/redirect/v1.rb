# frozen_string_literal: true

module ApiRedirect
  module Redirect
    class V1 < BaseApi
      resource :redirect do
        get do
          headers
        end
      end
    end
  end
end