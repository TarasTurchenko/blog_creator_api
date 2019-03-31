# frozen_string_literal: true

module ApiEntities
  module Post
    class Post < Grape::Entity
      expose :title
      expose :published
      expose :description
      expose :attrs
    end
  end
end