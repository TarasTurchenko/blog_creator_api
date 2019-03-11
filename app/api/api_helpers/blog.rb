# frozen_string_literal: true

module ApiHelpers
  module Blog
    def current_blog
      current_user.blog
    end
  end
end