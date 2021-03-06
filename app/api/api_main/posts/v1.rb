# frozen_string_literal: true

module ApiMain
  module Posts
    class V1 < BaseApi
      helpers ApiHelpers::PostHelpers

      resources :posts do
        desc 'Create new post'
        params do
          requires :title, type: String
        end
        post do
          params = declared_params
          params[:blog] = current_blog
          post = Post.create!(params)
          present(:post, post, with: ApiEntities::Post::ListItem)
        end

        desc 'Get all post'
        params do
          optional :published, type: Boolean
        end
        get do
          if params[:published]
            posts = current_blog.published_posts.order(:created_at)
            present(:posts, posts, with: ApiEntities::Post::Named)
          else
            posts = current_blog.posts.order(id: :desc)
            present(:posts, posts, with: ApiEntities::Post::ListItem)
          end
        end

        params do
          requires :post_id, type: String
        end
        route_param :post_id do
          before { find_current_post! }

          desc 'Get all post data'
          get do
            present(:post, current_post, with: ApiEntities::Post::Full)
          end

          desc 'Update post settings'
          params do
            optional :title, type: String

            optional :attrs, type: Hash do
              optional :offsets, type: Hash do
                optional :top, type: Integer
                optional :right, type: Integer
                optional :bottom, type: Integer
                optional :left, type: Integer
              end

              optional :bg_color, type: String
              optional :bg_image, type: String

              optional :thumbnail, type: String
            end
          end
          put do
            params = declared_params.except(:post_id)
            current_post.attributes = params.except(:attrs)
            current_post.update_attrs!(params[:attrs])
            present(:post, current_post, with: ApiEntities::Post::Post)
          end

          desc 'Delete post'
          delete do
            current_post.run_destroy_worker
            body(false)
          end

          desc 'Make post available for other anyone'
          post :publish do
            current_post.publish
            nil
          end

          desc 'Unshare page'
          post :unpublish do
            current_post.unpublish
            nil
          end

          desc 'Preview for built post page'
          content_type :html, 'text/html'
          format :html

          get :preview do
            PostViewModel::Post.new(current_post).render_html
          end
        end
      end
    end
  end
end
