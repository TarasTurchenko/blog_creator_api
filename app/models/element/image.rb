# frozen_string_literal: true

class Element
  class Image < Element
    KIND = :image.freeze
    DEFAULT_BLOCK = {
      src: Constants::Images::PLACEHOLDER,
      alt: 'Placeholder image'
    }.freeze
  end
end