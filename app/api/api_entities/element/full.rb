# frozen_string_literal: true

module ApiEntities
  module Element
    class Full < Grape::Entity
      expose :id
      expose :size
      expose :attrs
      expose :position
      expose :kind, &:kind
    end
  end
end
