# frozen_string_literal: true

module PostHelper
  def build_element_size(size)
    "app-grid__element--#{size}"
  end

  def element_template(element_type)
    "post/elements/#{element_type}"
  end
end
