# frozen_string_literal: true

class Element::Image < Element
  def default_block_attrs
    {
      src: Config::Images::PLACEHOLDER,
      alt: 'Placeholder image'
    }
  end
end
