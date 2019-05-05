# frozen_string_literal: true

module ApiEntities
  module Container
    class Full < ApiEntities::Base
      expose :id
      expose :attrs
      expose :position

      expose :elements do |post|
        ApiEntities::Element::Full.represent(post.elements)
      end
    end
  end
end
