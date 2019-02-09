# frozen_string_literal: true

module ApplicationHelper
  def insert_styles(attributes)
    attributes = attributes.delete_if { |_, value| value.blank? }
    attributes = attributes.map { |property, value| "#{property}:#{value};" }
    attributes.join ''
  end
end
