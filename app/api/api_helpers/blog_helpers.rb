# frozen_string_literal: true

module ApiHelpers
  module BlogHelpers
    attr_reader :current_blog

    def find_current_blog!
      @current_blog = current_user.blog
      create_blog! unless current_blog
    end
  end
end
