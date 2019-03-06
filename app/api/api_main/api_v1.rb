# frozen_string_literal: true

module ApiMain
  class ApiV1 < Grape::API
    mount ApiMain::Auth::V1

    before { authenticate! }

    mount ApiMain::Blogs::V1
    mount ApiMain::Posts::V1
    mount ApiMain::Containers::V1
    mount ApiMain::Elements::V1

    mount ApiMain::Images::V1
  end
end