# frozen_string_literal: true

module MainApi
  module Elements
    class V1 < Grape::API
      version 'v1', using: :path

      helpers do
        params :common_element_options do
          optional :bg_color, type: String
          optional :bg_image, type: String
          optional :offset_bottom, type: String
          optional :offset_left, type: String
          optional :offset_right, type: String
          optional :offset_top, type: String
        end

        def update_element_settings
          element = Element.find params[:element_id]
          declared = declared_params
          element.attributes = declared.except(:element_id, :main_settings)
          element.update_main_settings declared[:main_settings]
          element.save!
        end
      end

      desc 'Create new element'
      params do
        requires :container_id, type: Integer
        requires :position, type: Integer
        requires :kind, type: Symbol, values: Element::KINDS, desc: 'Type of element'
        requires :size, type: Integer
      end
      post 'containers/:container_id/elements' do
        Element.create! declared_params
      end

      desc 'Mass update elements sizes'
      params do
        requires :sizes, type: Array do
          requires :id, type: Integer
          requires :size, type: Integer
        end
      end
      patch 'elements/sizes' do
        Element.update_sizes declared_params[:sizes]
        body false
      end

      params do
        requires :element_id, type: Integer
      end
      resources 'elements/:element_id' do
        delete do
          Element.find(params[:element_id]).destroy!
          body false
        end

        params do
          requires :position, type: Integer
        end
        patch :position do
          element = Element.find params[:element_id]
          element.move position
        end

        params do
          use :common_element_options
          requires :main_settings, type: Hash do
            optional :content, type: String
          end
        end
        put(:text) { update_element_settings }

        params do
          use :common_element_options
          requires :main_settings, type: Hash do
            optional :alt, type: String
            optional :src, type: String
          end
        end
        put(:image) { update_element_settings }

        params do
          use :common_element_options
          requires :main_settings, type: Hash do
            optional :destination_type, type: String, values: Element::LINK_DESTINATION_TYPES
            optional :text, type: String

            given destination_type: ->(val) { val == 'external' } do
              requires :destination, type: String, regexp: Constants::Regexps::URL
            end

            given destination_type: ->(val) { val == 'post' } do
              requires :destination, type: Integer, desc: 'Post id'
            end
          end
        end
        put(:link) { update_element_settings }

        params do
          use :common_element_options
        end
        put :blank do
          element = params[:element_id]
          element.update! declared_params.except(:element_id)
          element
        end
      end
    end
  end
end
