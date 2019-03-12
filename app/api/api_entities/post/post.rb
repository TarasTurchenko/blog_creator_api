# frozen_string_literal: true

module ApiEntities
  module Post
    class Post < Grape::Entity
      expose :title
      expose :published
      expose :bg_color
      expose :bg_image
      expose :thumbnail
      expose :description
      expose :offset_top
      expose :offset_right
      expose :offset_bottom
      expose :offset_left
    end
  end
end