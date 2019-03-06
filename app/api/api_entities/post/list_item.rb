# frozen_string_literal: true

module ApiEntities
  module Post
    class ListItem < Grape::Entity
        expose :id
        expose :title
        expose :published
    end
  end
end