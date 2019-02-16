# frozen_string_literal: true

module Representation
  class BlogTemplate < Base
    IGNORED_ATTRIBUTES = %w(published)

    attr_accessor :id, :author, :name, :last_post, :posts, :publish_mode

    def initialize(model, publish_mode)
      self.attributes = model.attributes.except(*IGNORED_ATTRIBUTES)
      self.posts = model.published_posts.to_a
      self.last_post = posts.delete_at(0)
      self.publish_mode = publish_mode
    end

    def posts?
      last_post.present?
    end

    def post_path(post_id)
      return post_published_path(post_id) if publish_mode

      post_preview_path(post_id)
    end

    private

    def post_preview_path(post_id)
      "/v1/posts/#{post_id}/preview"
    end

    def post_published_path(post_id)
      Helpers::Aws.build_cdn_url("blogs/#{id}/posts/#{post_id}/index.html")
    end
  end
end