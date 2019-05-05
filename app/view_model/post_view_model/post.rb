# frozen_string_literal: true

module PostViewModel
  class Post < ApplicationViewModel
    PREVIEW_LAYOUT_TEMPLATE = 'post/preview'
    PUBLISHED_LAYOUT_TEMPLATE = 'post/published'

    HTML_TEMPLATE = 'post/index'
    STYLES_TEMPLATE = 'post/styles'

    attr_accessor :publish_mode, :containers

    def initialize(model, publish_mode = false)
      super(model)
      self.publish_mode = publish_mode
      prepare_containers
    end

    def render_html
      payload = { post: self }
      payload[:styles_url] = published_styles_url if publish_mode

      render(
        template: HTML_TEMPLATE,
        assigns: payload,
        layout: layout_template_name
      )
    end

    def render_styles
      render(template: STYLES_TEMPLATE, assigns: { post: self })
    end

    private

    def published_styles_url
      "#{model.published_dir_path}/styles.css"
    end

    def layout_template_name
      publish_mode ? PUBLISHED_LAYOUT_TEMPLATE : PREVIEW_LAYOUT_TEMPLATE
    end

    def permitted_model_attrs
      %i[id title blog_id attrs]
    end

    def prepare_containers
      self.containers = model.containers_with_order.map do |container|
        PostViewModel::Container.new(container, publish_mode)
      end
    end
  end
end
