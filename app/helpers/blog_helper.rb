# frozen_string_literal: true

module BlogHelper
  POSTS_PREVIEW_PLACEHOLDER = 'blog/placeholder'
  POSTS_PREVIEW_CONTENT = 'blog/content'

  def content_template
    @blog.posts? ? POSTS_PREVIEW_CONTENT : POSTS_PREVIEW_PLACEHOLDER
  end

  def post_preview_path(post_id)
    "/v1/posts/#{post_id}/preview"
  end
end
