# frozen_string_literal: true

module Representation
  class ElementTemplate < Base
    attr_accessor(
      :id,
      :kind,
      :attrs,
      :position,
      :size,
      :container_id,
      :publish_mode
    )

    def initialize(model, publish_mode)
      puts model.attributes
      self.attributes = model.attributes
      self.publish_mode = publish_mode
    end
  end
end
