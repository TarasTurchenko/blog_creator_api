# frozen_string_literal: true

class Element::Text < Element
  def default_block_attrs
    { content: 'Hey! Your text will be here' }
  end
end
