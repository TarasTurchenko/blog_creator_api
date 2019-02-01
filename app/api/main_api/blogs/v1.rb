# frozen_string_literal: true

module MainApi
  module Blogs
    class V1 < Grape::API
      version 'v1', using: :path

      desc 'Create new blog'
      params do
        requires :data, type: Hash do
          requires :name, type: String
          requires :author, type: String
        end
      end
      post :blogs do
        Blog.create! declared_params[:data]
      end
    end
  end
end
