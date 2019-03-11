# frozen_string_literal: true

module ApiMain
  module Posts
    class V1 < Grape::API
      version 'v1', using: :path

      params do
        requires :blog_id, type: Integer
      end
      resources 'blogs/:blog_id/posts' do
        desc 'Create new post'
        params do
          requires :title, type: String
        end
        post do
          post = Post.create!(declared_params)
          present :post, post, with: ApiEntities::Post::ListItem
        end

        desc 'Get all post for blog'
        get do
          blog = Blog.find params[:blog_id]
          posts = blog.posts.order id: :desc
          present :posts, posts, with: ApiEntities::Post::ListItem
        end
      end

      params do
        requires :post_id, type: String
      end
      resources 'posts/:post_id' do
        desc 'Get all post data'
        get do
          post = Post.find(params[:post_id]).capture_attrs
          present :post, post
        end

        desc 'Update post settings'
        params do
          optional :title, type: String

          optional :offset_top, type: Integer
          optional :offset_right, type: Integer
          optional :offset_bottom, type: Integer
          optional :offset_left, type: Integer

          optional :bg_color, type: String
          optional :bg_image, type: String

          optional :thumbnail, type: String
        end
        put do
          post = Post.find params[:post_id]
          post.update! declared_params.except(:post_id)
          present :post, post
        end

        desc 'Delete post'
        delete do
          Post.find(params[:post_id]).destroy!
          body false
        end

        desc 'Make post available for other anyone'
        post :publish do
          url = Post.find(params[:post_id]).publish
          present :url, url
        end

        desc 'Unshare page'
        post :unpublish do
          Post.find(params[:post_id]).unpublish
          nil
        end

        desc 'Preview for built post page'
        content_type :html, 'text/html'
        format :html
        get :preview do
          post = Post.find(params[:post_id])

          ApplicationController.render(
            template: 'post/index',
            assigns: { post: post.template_representation },
            layout: 'post/preview'
          )
        end
      end
    end
  end
end
