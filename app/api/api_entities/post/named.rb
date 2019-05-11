# frozen_string_literal: true

module ApiEntities
  module Post
    class Named < ApiEntities::Base
      expose :id
      expose :title
    end
  end
end
