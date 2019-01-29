module BlogPreviewHelper
  def posts?
    @blog['last_post'].present?
  end

  def posts_template
    posts? ? Templates::POSTS_CONTENT : Templates::POSTS_PLACEHOLDER
  end
end
