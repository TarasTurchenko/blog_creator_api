module PostWorker
  class Publish < ApplicationWorker
    attr_accessor :post, :html_path, :css_path

    def perform(post_id, html_path, css_path)
      self.post = Post.find(post_id)
      self.html_path = html_path
      self.css_path = css_path

      publish
      post.blog.publish

      AssetsWorker::ResetCaches.perform_async(html_path, css_path)

      post.update!(published: true) unless post.published
    end

    private

    def publish
      post = self.post.template_representation(true)
      Helpers::Aws.upload_to_storage(html_path, render_html(post))
      styles = CSS_COMPRESSOR.compress(render_css(post))
      Helpers::Aws.upload_to_storage(css_path, styles)
    end

    def render_html(post)
      styles_url = Helpers::Aws.build_cdn_url(css_path)

      ApplicationController.render(
        template: 'post/index',
        assigns: { post: post, styles_url: styles_url },
        layout: 'post/published'
      )
    end

    def render_css(post)
      ApplicationController.render(
        template: 'post/styles',
        assigns: { post: post }
      )
    end
  end
end
