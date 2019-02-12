# frozen_string_literal: true

module Representation
  class BlogTemplate < Base
    attr_accessor :id, :author, :name, :published, :last_post, :posts

    def initialize(model)
      self.attributes = model.attributes
      self.posts = model.published_posts.to_a
      self.last_post = posts.delete_at(0)
    end
  end
end