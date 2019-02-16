# frozen_string_literal: true

module Representation
  class BlogTemplate < Base
    IGNORED_ATTRIBUTES = %w(published)

    attr_accessor :id, :author, :name, :last_post, :posts

    def initialize(model)
      self.attributes = model.attributes.except(*IGNORED_ATTRIBUTES)
      self.posts = model.published_posts.to_a
      self.last_post = posts.delete_at(0)
    end

    def posts?
      last_post.present?
    end
  end
end