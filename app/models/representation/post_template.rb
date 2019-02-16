# frozen_string_literal: true

module Representation
  class PostTemplate < Base
    attr_accessor(
      :id,
      :bg_color,
      :bg_image,
      :description,
      :offset_bottom,
      :offset_left,
      :offset_right,
      :offset_top,
      :published,
      :thumbnail,
      :title,
      :blog,
      :blog_id,
      :containers,
      :additional_styles,
      :publish_mode
    )

    def initialize(model, publish_mode)
      self.attributes = model.attributes
      self.blog = model.blog
      self.publish_mode = publish_mode
      self.containers = containers_representations(model)
    end

    private

    def containers_representations(post)
      post.containers_with_order.map do |container|
        container.template_representation publish_mode
      end
    end
  end
end