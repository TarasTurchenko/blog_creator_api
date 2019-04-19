# frozen_string_literal: true

module ApiEntities
  module Post
    class ListItem < ApiEntities::Base
        expose :id
        expose :title
        expose :published
    end
  end
end