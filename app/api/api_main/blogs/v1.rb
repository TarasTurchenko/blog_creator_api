# frozen_string_literal: true

module ApiMain
  module Blogs
    class V1 < BaseApi
      resources :blog do
        desc 'Create new blog'
        params do
          requires :name, type: String
          requires :author, type: String
        end
        post do
          name = declared_params[:name]
          params = declared_params.merge(
            user: current_user,
            subdomain: ActiveSupport::Inflector.parameterize(name)
          )
          blog = Blog.create!(params)
          present(:blog, blog, with: ApiEntities::Blog::Blog)
        end

        before { find_current_blog! }

        desc 'Homepage preview'
        content_type :html, 'text/html'
        format :html
        get :preview do
          BlogViewModel::Blog.new(current_blog).render_html
        end
      end
    end
  end
end
