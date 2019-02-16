# frozen_string_literal: true

module Services
  class BlogPublisher
    attr_accessor :blog, :html_path

    def initialize(blog)
      self.blog = blog
      self.html_path = "blogs/#{blog.id}/index.html"
    end

    def publish
      upload_html
    end

    def invalidation_items
      ["/#{html_path}"]
    end

    private

    def upload_html
      S3_BUCKET.put_object(
        acl: Constants::Storage::Permissions::PUBLIC_READ,
        body: render_html,
        content_type: 'text/html',
        key: html_path
      )
    end

    def render_html
      ApplicationController.render(
        template: 'blog/published',
        layout: 'blog/published',
        assigns: {blog: blog.template_representation}
      )
    end
  end
end
