# frozen_string_literal: true

# == Schema Information
#
# Table name: elements
#
#  id           :bigint(8)        not null, primary key
#  attrs        :jsonb
#  kind         :integer          not null
#  position     :integer          not null
#  size         :integer          not null
#  type         :string
#  container_id :integer          not null
#
# Indexes
#
#  index_elements_on_container_id  (container_id)
#

class Element
  class Link < Element
    LINK_DESTINATION_TYPES = %w[external homepage post].freeze

    def default_block_attrs
      {
        destination_type: 'external',
        destination: 'http://example-link.com',
        text: 'Example link'
      }
    end

    def template_model
      Representation::ElementLinkTemplate
    end
  end
end
