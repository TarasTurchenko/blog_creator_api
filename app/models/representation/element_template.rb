# frozen_string_literal: true

module Representation
  class ElementTemplate < Base
    attr_accessor(
      :id,
      :bg_color,
      :bg_image,
      :kind,
      :main_settings,
      :offset_bottom,
      :offset_left,
      :offset_right,
      :offset_top,
      :position,
      :size,
      :container_id,
      :publish_mode
    )

    def initialize(model, publish_mode)
      self.attributes = model.attributes
      self.publish_mode = publish_mode
    end
  end
end
