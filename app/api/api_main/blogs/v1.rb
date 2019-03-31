# frozen_string_literal: true

module ApiMain
  module Blogs
    class V1 < Grape::API
      resources :blog do
        desc 'Create new blog'
        params do
          requires :name, type: String
          requires :author, type: String
        end
        post do
          params = declared_params
          params[:user] = current_user
          blog = Blog.create! params
          present :blog, blog, with: ApiEntities::Blog::Blog
        end

        before { find_current_blog! }

        desc 'Make homepage available for other anyone'
        post :publish do
          url = current_blog.publish
          present :url, url
        end

        desc 'Unshare home page and all posts'
        post :unpublish do
          current_blog.unpublish
          nil
        end

        desc 'Homepage preview'
        content_type :html, 'text/html'
        format :html
        get :preview do
          ApplicationController.render(
            template: 'blog/index',
            assigns: { blog: current_blog.template_representation },
            layout: 'blog'
          )
        end
      end
    end
  end
end
