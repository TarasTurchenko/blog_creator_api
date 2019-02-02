# frozen_string_literal: true

module Element
  class Text < BaseElement
    defaults(
      offset_top: '20px',
      offset_right: '5%',
      offset_bottom: '20px',
      offset_left: '5%',
      main_settings: { content: 'Hey! Your text will be here' },
      kind: :text
    )
  end
end