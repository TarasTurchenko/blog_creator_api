Integer# frozen_string_literal: true

module ApiMain
  module Elements
    class V1 < Grape::API
      version 'v1', using: :path

      helpers do
        params :common_element_options do
          optional :bg_color, type: String
          optional :bg_image, type: String
          optional :offset_bottom, type: Integer
          optional :offset_left, type: Integer
          optional :offset_right, type: Integer
          optional :offset_top, type: Integer
        end

        def update_element_settings
          element = Element.find params[:element_id]
          declared = declared_params
          element.attributes = declared.except(:element_id, :main_settings)
          element.update_main_settings declared[:main_settings]
          element.save!
          present :element, element
        end
      end

      desc 'Create new element'
      params do
        requires :container_id, type: Integer
        requires :position, type: Integer
        requires :kind,
                 type: Symbol,
                 values: Element::KINDS,
                 desc: 'Type of element'
        requires :size, type: Integer
      end
      post 'containers/:container_id/elements' do
        element = Element.create! declared_params
        present :element, element
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
        nil
      end

      params do
        requires :element_id, type: Integer
      end
      resources 'elements/:element_id' do
        desc 'Delete element'
        delete do
          Element.find(params[:element_id]).destroy!
          body false
        end

        desc 'Change element position inside container'
        params do
          requires :position, type: Integer
        end
        patch :position do
          element = Element.find params[:element_id]
          element.move position
          nil
        end

        desc 'Update settings for text element'
        params do
          use :common_element_options
          requires :main_settings, type: Hash do
            optional :content, type: String
          end
        end
        put(:text) { update_element_settings }

        desc 'Update settings for image element'
        params do
          use :common_element_options
          requires :main_settings, type: Hash do
            optional :alt, type: String
            optional :src, type: String
          end
        end
        put(:image) { update_element_settings }

        desc 'Update settings for link element'
        params do
          use :common_element_options
          requires :main_settings, type: Hash do
            optional :destination_type,
                     type: String,
                     values: Element::LINK_DESTINATION_TYPES
            optional :text, type: String

            given destination_type: ->(val) { val == 'external' } do
              requires :destination,
                       type: String,
                       regexp: Constants::Regexps::URL
            end

            given destination_type: ->(val) { val == 'post' } do
              requires :destination, type: Integer, desc: 'Post id'
            end
          end
        end
        put(:link) { update_element_settings }

        desc 'Update settings for blank element'
        params do
          use :common_element_options
        end
        put :blank do
          element = params[:element_id]
          element.update! declared_params.except(:element_id)
          present :element, element
        end
      end
    end
  end
end
