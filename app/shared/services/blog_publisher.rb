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

    def page_url
      Helpers::Aws.build_cdn_url("#{dir}/index.html")
    end

    private

    def render_html
      ApplicationController.render(
        template: 'blog/index',
        layout: 'blog',
        assigns: { blog: blog.template_representation(true) }
      )
    end

    def generate_unique_key
      "#{blog.id}_#{DateTime.now}"
    end
  end
end
