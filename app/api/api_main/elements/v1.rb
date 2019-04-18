# frozen_string_literal: true

module ApiMain
  module Elements
    class V1 < Grape::API
      namespace :containers do
        helpers ApiHelpers::ContainerHelpers

        helpers do
          def check_max_elements_limit!
            elements_count = current_container.elements.count
            max_elements_count! if elements_count >= Container::MAX_ELEMENTS_COUNT
          end
        end

        before do
          find_current_container!
          check_max_elements_limit!
        end

        desc 'Create new element'
        params do
          requires :container_id, type: Integer
          requires :position, type: Integer
          requires :kind, type: Symbol, desc: 'Type of element'
          # requires :size, type: Integer
        end
        post ':container_id/elements' do
          attrs = declared_params.except(:kind)
          # Half size of container. get size from params in future versions
          attrs[:size] = 6

          element_constructor = Element.element_constructor(params[:kind])
          element = element_constructor.create!(attrs)

          present(:element, element, with: ApiEntities::Element::Full)
        end
      end

      params do
        requires :element_id, type: Integer
      end
      resources 'elements/:element_id' do
        helpers ApiHelpers::ElementHelpers
        helpers do
          params :common_element_options do
            optional :offsets, type: Hash, default: {} do
              optional :top, type: Integer
              optional :right, type: Integer
              optional :bottom, type: Integer
              optional :left, type: Integer
            end

            optional :bg_color, type: String
            optional :bg_image, type: String
          end

          def update_element_settings
            params = declared_params.except(:element_id)
            current_element.update_attrs(params)
            current_element.save!
            present(:element, current_element, with: ApiEntities::Element::Full)
          end
        end

        before { find_current_element! }

        desc 'Delete element'
        delete do
          current_element.destroy!
          body(false)
        end

        desc 'Change element position inside container'
        params do
          requires :position, type: Integer
        end
        patch :position do
          current_element.move(position)
          nil
        end

        desc 'Update settings for text element'
        params do
          use :common_element_options
          optional :block, type: Hash, default: {} do
            optional :content, type: String
          end
        end
        put(:text) { update_element_settings }

        desc 'Update settings for image element'
        params do
          use :common_element_options
          optional :block, type: Hash, default: {} do
            optional :alt, type: String
            optional :src, type: String
          end
        end
        put(:image) { update_element_settings }

        desc 'Update settings for link element'
        params do
          use :common_element_options
          optional :block, type: Hash, default: {} do
            optional :destination_type,
                     type: String,
                     values: Element::Link::LINK_DESTINATION_TYPES

            optional :text, type: String

            given destination_type: ->(val) { val == 'external' } do
              requires :destination,
                       type: String,
                       regexp: Constants::Regexps::URL,
                       desc: 'Custom url destination'
            end

            given destination_type: ->(val) { val == 'post' } do
              requires :destination, type: Integer, desc: 'Post id'
            end
          end
        end
        put(:link) { update_element_settings }
      end
    end
  end
end
