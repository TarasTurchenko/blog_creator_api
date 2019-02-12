# frozen_string_literal: true

class BlogPreviewController < ApplicationController
  layout 'blog/preview'

  def index
    @blog = Blog.find(params[:blog_id]).template_representation
  end
end
