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
      get 'blogs/:blog_id/publish' do
        @blog = Blog.find(params[:blog_id]).template_representation
        
        html = ApplicationController.render(
          template: 'blog/published',
          layout: 'blog/published',
          assigns: {blog: @blog}
        )
        html
      end
    end
  end
end
