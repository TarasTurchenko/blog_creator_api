# frozen_string_literal: true

module MainApi
  module Containers
    class V1 < Grape::API
      version 'v1', using: :path

      params do
        requires :post_id, type: Integer
        requires :position, type: Integer
      end
      post 'posts/:post_id/containers' do
        Container.create! declared_params
      end

      params do
        requires :container_id, type: Integer
      end
      resources 'containers/:container_id' do
        params do
          optional :offset_top, type: String
          optional :offset_right, type: String
          optional :offset_bottom, type: String
          optional :offset_left, type: String
          optional :bg_color, type: String
          optional :bg_image, type: String
        end
        put do
          container = Container.find params[:container_id]
          container.update! declared_params.except(:container_id)
          container
        end

        delete do
          Container.find(params[:container_id]).destroy!
          body false
        end

        params do
          requires :position, type: Integer
        end
        patch :position do
          container = Container.find params[:container_id]
          container.move params[:position]
        end
      end
    end
  end
end