# frozen_string_literal: true

module ApiEntities
  module Blog
    class Blog < Grape::Entity
      expose :name
      expose :author
      expose :published
    end
  end
end