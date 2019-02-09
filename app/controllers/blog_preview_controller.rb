# frozen_string_literal: true

class BlogPreviewController < ApplicationController
  layout 'blog/preview'

  def index
    @blog = Blog.find(params[:blog_id])
    @posts = @blog.published_posts.to_a
    @last_post = @posts.delete_at(0)
  end
end
