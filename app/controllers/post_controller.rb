# frozen_string_literal: true

class PostController < ApplicationController
  layout 'post/preview'

  def preview
    @post = Post.find(params[:post_id]).template_representation
  end
end
