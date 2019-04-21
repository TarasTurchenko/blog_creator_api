# frozen_string_literal: true

module BlogViewModel
  class Post < ApplicationViewModel
    attr_accessor :publish_mode

    def initialize(model, publish_mode)
      super(model)
      self.publish_mode = publish_mode
    end

    def path
      return '#' unless publish_mode

      post_published_path
    end

    private

    def permitted_model_attrs
      [:id, :title, :description, :attrs]
    end

    def post_published_path
      Helpers::Aws.build_cdn_url(model.published_page_path)
    end
  end
end
