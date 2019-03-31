# frozen_string_literal: true

module Elements
  module Defaults
    TEXT = { content: 'Hey! Your text will be here' }.freeze

    IMAGE = {
      src: Constants::Images::PLACEHOLDER,
      alt: 'Placeholder image'
    }.freeze

    LINK = {
      destination_type: 'external',
      destination: 'http://example-link.com',
      text: 'Example link'
    }.freeze

    BLOCK = {
      'text' => TEXT,
      'image' => IMAGE,
      'link' => LINK
    }.freeze
  end
end