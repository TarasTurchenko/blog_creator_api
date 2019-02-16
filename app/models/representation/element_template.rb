# frozen_string_literal: true

module Representation
  class ElementTemplate < Base
    attr_accessor(
      :id,
      :bg_color,
      :bg_image,
      :kind,
      :main_settings,
      :offset_bottom,
      :offset_left,
      :offset_right,
      :offset_top,
      :position,
      :size,
      :container_id,
      :publish_mode
    )

    def initialize(model, publish_mode)
      self.attributes = model.attributes
      self.publish_mode = publish_mode
    end

    def link_destination(blog_id)
      raise BlogCreatorError, 'Element must be a link' if kind != 'link'

      destination = main_settings['destination']

      case main_settings['destination_type']
      when 'post'
        post_path(blog_id, destination)
      when 'homepage'
        homepage_path(blog_id)
      else
        destination
      end
    end

    private

    def post_path(blog_id, post_id)
      return published_post_path(blog_id, post_id) if publish_mode

      post_preview_path post_id
    end

    def published_post_path(blog_id, post_id)
      Helpers::Aws.build_cdn_url "blogs/#{blog_id}/posts/#{post_id}/index.html"
    end

    def post_preview_path(post_id)
      "/v1/posts/#{post_id}/preview"
    end

    def homepage_path(blog_id)
      return published_homepage_path(blog_id) if publish_mode

      homepage_preview_path blog_id
    end

    def published_homepage_path(blog_id)
      Helpers::Aws.build_cdn_url("blogs/#{blog_id}/index.html")
    end

    def homepage_preview_path(blog_id)
      "/v1/blogs/#{blog_id}/preview"
    end
  end
end