# frozen_string_literal: true

module BlogViewModel
  class Blog < ApplicationViewModel
    PREVIEW_LAYOUT_TEMPLATE = 'blog/preview'
    PUBLISH_LAYOUT_TEMPLATE = 'blog/published'

    PLACEHOLDER_TEMPLATE = 'blog/placeholder'
    POSTS_TEMPLATE = 'blog/posts'

    attr_accessor :posts, :publish_mode

    def initialize(model, publish_mode = false)
      super(model)
      self.publish_mode = publish_mode
      prepare_posts(model)
    end

    def render_html
      render(
        template: content_template_name,
        layout: layout_template_name,
        assigns: { blog: self }
      )
    end

    def posts?
      !posts.empty?
    end

    private

    def permitted_model_attrs
      %i[id name author]
    end

    def prepare_posts(model)
      posts = model.published_posts.order(updated_at: :desc)
      self.posts = posts.map.with_index do |post, index|
        BlogViewModel::Post.new(post, publish_mode, index.zero?)
      end
    end

    def content_template_name
      posts? ? POSTS_TEMPLATE : PLACEHOLDER_TEMPLATE
    end

    def layout_template_name
      publish_mode ? PUBLISH_LAYOUT_TEMPLATE : PREVIEW_LAYOUT_TEMPLATE
    end
  end
end
