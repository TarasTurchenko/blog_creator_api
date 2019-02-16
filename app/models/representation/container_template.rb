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
      :elements,
      :publish_mode
    )

    def initialize(model, publish_mode)
      self.attributes = model.attributes
      self.publish_mode = publish_mode
      self.elements = elements_representations(model)
    end

    private

    def elements_representations(container)
      container.elements_with_order.map do |element|
        element.template_representation publish_mode
      end
    end
  end
end