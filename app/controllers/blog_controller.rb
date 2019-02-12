# frozen_string_literal: true

class BlogController < ApplicationController
  layout 'blog/preview'

  def preview
    @blog = Blog.find(params[:blog_id]).template_representation
  end
end
