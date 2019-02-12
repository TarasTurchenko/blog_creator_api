# frozen_string_literal: true

module BlogHelper
  POSTS_PREVIEW_PLACEHOLDER = "blog/placeholder/preview"
  POSTS_PREVIEW_CONTENT = "blog/content/preview"

  def posts_template
    @blog.posts? ? POSTS_PREVIEW_CONTENT : POSTS_PREVIEW_PLACEHOLDER
  end

  def post_preview_path(post_id)
    "/posts/#{post_id}/preview"
  end
end
