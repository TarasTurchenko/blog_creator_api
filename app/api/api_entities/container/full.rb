# frozen_string_literal: true

module ApiEntities
  module Container
    class Full < Grape::Entity
      expose :id
      expose :attrs
      expose :position
      expose :elements, &:elements
    end
  end
end