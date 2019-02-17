# frozen_string_literal: true

module BlogHelper
  def blog_content_template
    template = @blog.posts? ? 'content' : 'placeholder'
    "blog/#{template}"
  end
end
