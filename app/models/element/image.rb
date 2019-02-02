# frozen_string_literal: true

module Element
  class Image < BaseElement
    defaults(
      offset_top: '20px',
      offset_right: '5%',
      offset_bottom: '20px',
      offset_left: '5%',
      main_settings: { src: Constants::Images::PLACEHOLDER, alt: 'Placeholder image' },
      kind: :text
    )
  end
end