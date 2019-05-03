# frozen_string_literal: true

module BlogViewModel
  class Post < ApplicationViewModel
    REGULAR_POST_TEMPLATE = 'blog/post/regular'.freeze
    NEWEST_POST_TEMPLATE = 'blog/post/newest'.freeze

    WRAPPER_TEMPLATE = 'blog/post/wrapper'.freeze

    attr_accessor :publish_mode, :is_newest

    def initialize(model, publish_mode, is_newest)
      super(model)
      self.publish_mode = publish_mode
      self.is_newest = is_newest
    end

    def render_html
      render(
        partial: template_name,
        layout: WRAPPER_TEMPLATE,
        locals: { post: self }
      )
    end

    def path
      return '#' unless publish_mode

      model.published_page_path
    end

    private

    def permitted_model_attrs
      [:id, :title, :description, :attrs]
    end

    def template_name
      is_newest ? NEWEST_POST_TEMPLATE : REGULAR_POST_TEMPLATE
    end
  end
end
