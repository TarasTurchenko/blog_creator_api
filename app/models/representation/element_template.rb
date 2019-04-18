# frozen_string_literal: true

module Representation
  class ElementTemplate < Base
    IGNORED_ATTRIBUTES = %w(type).freeze

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
      self.attributes = model.attributes.except(*IGNORED_ATTRIBUTES)
      self.kind = model.kind
      self.publish_mode = publish_mode
    end
  end
end
