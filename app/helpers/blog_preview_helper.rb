# frozen_string_literal: true

module BlogPreviewHelper
  def posts_template
    @blog.posts? ? Templates::POSTS_CONTENT : Templates::POSTS_PLACEHOLDER
  end

  def post_preview_path(post_id)
    "/posts/#{post_id}/preview"
  end
end
