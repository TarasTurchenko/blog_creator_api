# frozen_string_literal: true

module MainApi
  module Blogs
    class V1 < Grape::API
      version 'v1', using: :path

      desc 'Create new blog'
      params do
        requires :name, type: String
        requires :author, type: String
      end
      post :blogs do
        Blog.create! declared_params
      end

      params do
        requires :blog_id, type: Integer
      end
      post 'blogs/:blog_id/publish' do

      end
    end
  end
end
