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
      :containers
    )

    def initialize(model)
      self.attributes = model.attributes
      self.blog = model.blog
      containers = model.containers_with_order
      self.containers = containers.map(&:template_representation)
    end
  end
end