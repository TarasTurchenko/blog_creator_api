# frozen_string_literal: true

module BlogCreatorApi
  class Root < Grape::API
    format :json


    get :hello do
      'Hello World'
    end
  end
end