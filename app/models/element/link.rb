# frozen_string_literal: true

class Element::Link < Element
  LINK_DESTINATION_TYPES = %w[external homepage post].freeze

  def default_block_attrs
    {
      destination_type: 'external',
      destination: 'http://example-link.com',
      text: 'Example link'
    }
  end
end
