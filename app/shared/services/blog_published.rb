# frozen_string_literal: true

module Services
  class BlogPublished
    attr_accessor :blog, :html_path

    def initialize(blog)
      self.blog = blog
      self.html_path = "blogs/#{blog.publish_key}/index.html"
    end

    def publish
      upload_html
    end

    def reset_cdn_caches
      Helpers::Aws.invalidate_cdn_paths generate_unique_key, invalidation_items
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

    def generate_unique_key
      Digest::SHA1.hexdigest "#{blog.id}_#{DateTime.now}"
    end

    def invalidation_items
      ["/#{html_path}"]
    end
  end
end
