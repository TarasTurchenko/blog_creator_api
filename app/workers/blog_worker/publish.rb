# frozen_string_literal: true

module BlogWorker
  class Publish < ApplicationWorker
    attr_accessor :blog, :html_path

    def perform(blog_id, dir_path)
      self.blog = Blog.find(blog_id)
      self.html_path = "#{dir_path}/index.html"

      publish

      AssetsWorker::ResetCaches.perform_async(html_path)

      blog.update!(published: true) unless blog.published
    end

    private

    def publish
      Helpers::Aws.upload_to_storage(html_path, render_html)
    end

    def render_html
      payload = { blog: blog.template_representation(true) }

      ApplicationController.render(
        template: 'blog/index',
        layout: 'blog',
        assigns: payload
      )
    end
  end
end