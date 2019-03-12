# frozen_string_literal: true

module ApiEntities
  module Container
    class Full < Grape::Entity
      expose :id
      expose :bg_color
      expose :bg_image
      expose :post_id
      expose :position
      expose :offset_top
      expose :offset_right
      expose :offset_bottom
      expose :offset_left
      expose :elements, &:elements
    end
  end
end