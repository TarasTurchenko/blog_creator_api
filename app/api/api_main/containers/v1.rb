# frozen_string_literal: true

module ApiMain
  module Containers
    class V1 < BaseApi
      namespace :posts do
        helpers ApiHelpers::PostHelpers
        before { find_current_post! }

        desc 'Create new container'
        params do
          requires :post_id, type: Integer
          requires :position, type: Integer
        end
        post ':post_id/containers' do
          container = Container.create!(declared_params)
          present(:container, container)
        end
      end

      params do
        requires :container_id, type: Integer
      end
      resources 'containers/:container_id' do
        helpers ApiHelpers::ContainerHelpers
        before { find_current_container! }

        desc 'Update container settings'
        params do
          optional :offsets, type: Hash do
            optional :top, type: Integer
            optional :right, type: Integer
            optional :bottom, type: Integer
            optional :left, type: Integer
          end

          optional :bg_color, type: String
          optional :bg_image, type: String
        end
        put do
          params = declared_params.except(:container_id)
          current_container.update_attrs(params)
          current_container.save!
          present(:container, current_container)
        end

        desc 'Delete container and all elements for this container'
        delete do
          current_container.destroy!
          body(false)
        end

        desc 'Change container position inside page'
        params do
          requires :position, type: Integer
        end
        patch :position do
          current_container.move(params[:position])
          nil
        end
      end
    end
  end
end
