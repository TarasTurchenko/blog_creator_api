# frozen_string_literal: true

module BlogCreatorApi
  class Root < Grape::API
    helpers BlogCreatorApi::Shared::BaseHelpers

    format :json
  end
end