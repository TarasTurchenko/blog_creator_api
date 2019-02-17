# frozen_string_literal: true

Rails.application.routes.draw do
  get 'swagger', to: 'swagger#index'

  mount RootApi => '/'
end
