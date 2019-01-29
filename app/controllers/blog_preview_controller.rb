class BlogPreviewController < ApplicationController
  layout 'blank'

  def index
    @blog = Blog.find(params[:blog_id]).capture_preview_attrs
  end
end
