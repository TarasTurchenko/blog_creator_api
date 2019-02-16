# frozen_string_literal: true

module Services
  class BlogPublisher
    attr_accessor :blog, :dir

    def initialize(blog)
      self.blog = blog
      self.dir = "blogs/#{blog.id}"
    end

    def publish
      path = "#{dir}/index.html"
      Helpers::Aws.upload_to_storage path, render_html
    end

    def reset_cdn_caches
      Helpers::Aws.invalidate_cdn_paths generate_unique_key, ["/#{dir}/*"]
    end

    private

    def render_html
      ApplicationController.render(
        template: 'blog/published',
        layout: 'blog/published',
        assigns: {blog: blog.template_representation}
      )
    end

    def generate_unique_key
      "#{blog.id}_#{DateTime.now}"
    end
  end
end
