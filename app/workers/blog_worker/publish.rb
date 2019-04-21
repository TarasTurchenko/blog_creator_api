# frozen_string_literal: true

module BlogWorker
  class Publish < ApplicationWorker
    attr_accessor :blog, :html_path

    def perform(blog_id, dir_path)
      self.blog = Blog.find(blog_id)
      self.html_path = "#{dir_path}/index.html"

      publish

      AssetsWorker::ResetCaches.perform_async('/' + html_path)

      blog.update!(published: true) unless blog.published
    end

    private

    def publish
      blog = BlogViewModel::Blog.new(self.blog, true)
      Helpers::Aws.upload_to_storage(html_path, render_html(blog))
    end

    def render_html(blog)
      ApplicationController.render(
        template: 'blog/index',
        layout: 'blog',
        assigns: { blog: blog }
      )
    end
  end
end