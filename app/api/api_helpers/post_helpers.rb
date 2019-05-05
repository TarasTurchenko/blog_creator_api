# frozen_string_literal: true

module ApiHelpers
  module PostHelpers
    attr_reader :current_post

    def find_current_post!
      @current_post = current_blog.posts.find_by(id: params[:post_id])
      post_not_found! unless current_post
    end
  end
end
