# frozen_string_literal: true

module PostViewModel
  module Element
    class Base < ApplicationViewModel
      WRAPPER_STYLES_TEMPLATE = 'post/element/styles'
      WRAPPER_HTML_TEMPLATE = 'post/element/wrapper'

      TEMPLATE_NAME = ''

      attr_accessor :publish_mode

      def initialize(model, publish_mode)
        super(model)
        self.publish_mode = publish_mode
      end

      def render_html
        render(
          partial: self.class::TEMPLATE_NAME,
          assigns: { element: self },
          layout: WRAPPER_HTML_TEMPLATE
        )
      end

      def render_styles
        render(partial: WRAPPER_STYLES_TEMPLATE, assigns: { element: self })
      end

      def build_size_class
        "app-grid__element--#{size}"
      end

      private

      def permitted_model_attrs
        %i[id kind attrs size]
      end
    end
  end
end
