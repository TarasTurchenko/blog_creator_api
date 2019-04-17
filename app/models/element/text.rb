# frozen_string_literal: true

class Element
  class Text < Element
    KIND = :text.freeze
    DEFAULT_BLOCK = { content: 'Hey! Your text will be here' }.freeze
  end
end