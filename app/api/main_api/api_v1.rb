# frozen_string_literal: true

module MainApi
  class ApiV1 < Grape::API
    mount MainApi::Auth::V1

    before { authenticate! }

    mount MainApi::Blogs::V1
    mount MainApi::Posts::V1
    mount MainApi::Containers::V1
    mount MainApi::Elements::V1

    mount MainApi::Images::V1
  end
end