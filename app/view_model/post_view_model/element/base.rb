# frozen_string_literal: true

module PostViewModel
  module Element
    class Base < ApplicationViewModel
      attr_accessor :publish_mode

      def initialize(model, publish_mode)
        super(model)
        self.publish_mode = publish_mode
      end

      def build_size_class
        "app-grid__element--#{size}"
      end

      private

      def permitted_model_attrs
        [:id, :kind, :attrs, :size]
      end
    end
  end
end