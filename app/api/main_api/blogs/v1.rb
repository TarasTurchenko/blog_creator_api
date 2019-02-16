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
      resources 'blogs/:blog_id' do
        post :publish do
          url = Blog.find(params[:blog_id]).publish
          {url: url}
        end

        content_type :html, 'text/html'
        format :html
        get :preview do
          blog = Blog.find params[:blog_id]
          ApplicationController.render(
            template: 'blog/index',
            assigns: { blog: blog.template_representation },
            layout: 'blog'
          )
        end
      end
    end
  end
end
