# frozen_string_literal: true

# == Schema Information
#
# Table name: elements
#
#  id           :bigint(8)        not null, primary key
#  attrs        :jsonb
#  position     :integer          not null
#  size         :integer          not null
#  type         :string
#  container_id :integer          not null
#
# Indexes
#
#  index_elements_on_container_id  (container_id)
#

class Element < ApplicationRecord
  include SharedModels::PositionableModel
  include SharedModels::WithAttrsJson

  MAX_SIZE = 12

  before_create :set_defaults
  after_create :reorder
  after_destroy :reorder

  belongs_to :container

  validates :container_id, presence: true
  validates :size, presence: true, numericality: {
    only_integer: true, greater_than: 0,
    less_than_or_equal_to: MAX_SIZE
  }
  validates :position, POSITION_VALIDATIONS

  def self.element_constructor(kind)
    case kind.to_sym
    when :image
      Element::Image
    when :link
      Element::Link
    when :text
      Element::Text
    else
      raise(BlogCreatorError, "Unknown element kind \"#{kind}\"")
    end
  end

  def move(to)
    super(Element, to, container.elements_positions)
  end

  def kind
    type.delete_prefix('Element::').downcase
  end

  protected

  def default_block_attrs
    {}
  end

  def template_model
    Representation::ElementTemplate
  end

  private

  def reorder
    positions = container.elements_positions(id: :desc)
    save_position_changes(Element, positions)
  end

  def set_defaults
    self.attrs = attrs.deep_merge(block: default_block_attrs)
  end
end
