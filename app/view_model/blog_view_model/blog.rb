# frozen_string_literal: true

module BlogViewModel
  class Blog < ApplicationViewModel
    attr_accessor :posts, :newest_post, :publish_mode

    def initialize(model, publish_mode = false)
      super(model)
      self.publish_mode = publish_mode
      prepare_posts(model)
    end

    def posts?
      newest_post.present?
    end

    private

    def permitted_model_attrs
      [:id, :name, :author]
    end

    def prepare_posts(model)
      self.posts = model.published_posts.order(updated_at: :desc).map do |post|
        BlogViewModel::Post.new(post, publish_mode)
      end
      self.newest_post = posts.delete_at(0)
    end
  end
end
