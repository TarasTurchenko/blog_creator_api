# frozen_string_literal: true

module Representation
  class ContainerTemplate < Base
    attr_accessor(
      :id,
      :bg_color,
      :bg_image,
      :offset_bottom,
      :offset_left,
      :offset_right,
      :offset_top,
      :position,
      :post_id,
      :elements
    )

    def initialize(model)
      self.attributes = model.attributes
      self.elements = elements_representations(model)
    end

    private

    def elements_representations(container)
      container.elements_with_order.map(&:template_representation)
    end
  end
end