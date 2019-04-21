# frozen_string_literal: true

module PostViewModel
  class Post < ApplicationViewModel
    attr_accessor :publish_mode, :containers

    def initialize(model, publish_mode = false)
      super(model)
      self.publish_mode = publish_mode
      prepare_containers
    end

    private

    def permitted_model_attrs
      [:id, :title, :blog_id, :attrs]
    end

    def prepare_containers
      self.containers = model.containers_with_order.map do |container|
        PostViewModel::Container.new(container, publish_mode)
      end
    end

    def containers_representations(post)
      post.containers_with_order.map do |container|
        container.template_representation(publish_mode)
      end
    end
  end
end
