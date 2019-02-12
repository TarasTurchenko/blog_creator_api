# frozen_string_literal: true

class PostPreviewController < ApplicationController
  layout 'post/preview'

  def index
    @post = Post.find(params[:post_id]).template_representation
  end
end
