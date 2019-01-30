# frozen_string_literal: true

module BlogCreatorApi
  module Containers
    class V1 < Grape::API
      version 'v1', using: :path

      params do
        requires :post_id, type: Integer
      end
      resources 'posts/:post_id/containers' do
        params do
          requires :data, type: Hash do
            requires :position, type: Integer
          end
        end
        post do
          position = params[:data][:position]
          Container.create! post_id: params[:post_id], position: position
        end
      end
    end
  end
end