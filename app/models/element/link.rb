# frozen_string_literal: true

class Element
  class Link < Element
    KIND = :link.freeze
    DEFAULT_BLOCK = {
      destination_type: 'external',
      destination: 'http://example-link.com',
      text: 'Example link'
    }.freeze

    LINK_DESTINATION_TYPES = %w[external homepage post].freeze
  end
end