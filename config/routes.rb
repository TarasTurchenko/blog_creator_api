# frozen_string_literal: true

Rails.application.routes.draw do
  get 'swagger', to: 'swagger#index'

  get 'blogs/:blog_id/preview', to: 'blog#preview'
  get 'posts/:post_id/preview', to: 'post_preview#index'

  mount RootApi => '/'
end
