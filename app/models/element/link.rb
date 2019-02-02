# frozen_string_literal: true

module Element
  class Link < BaseElement
    defaults(
      offset_top: '20px',
      offset_right: '5%',
      offset_bottom: '20px',
      offset_left: '5%',
      main_settings: { destination_type: :external, destination: 'http://example-link.com', text: 'Example link' },
      kind: :text
    )
  end
end