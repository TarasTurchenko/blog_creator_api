# frozen_string_literal: true

module ApiEntities
  module Post
    class Post < ApiEntities::Base
      expose :title
      expose :published
      expose :description
      expose :attrs
    end
  end
end