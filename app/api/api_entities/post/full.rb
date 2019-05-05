# frozen_string_literal: true

module ApiEntities
  module Post
    class Full < ApiEntities::Post::Post
      expose :containers do |post|
        ApiEntities::Container::Full.represent(post.containers_with_order)
      end
    end
  end
end
