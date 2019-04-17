# frozen_string_literal: true
# == Schema Information
#
# Table name: elements
#
#  id           :bigint(8)        not null, primary key
#  attrs        :jsonb
#  kind         :integer          not null
#  position     :integer          not null
#  size         :integer          not null
#  container_id :integer          not null
#
# Indexes
#
#  index_elements_on_container_id  (container_id)
#

class Element < ApplicationRecord
  include SharedModels::PositionableModel
  include SharedModels::WithAttrsJson

  MAX_SIZE = 12.freeze
  KINDS = %i[text image link].freeze

  DEFAULT_BLOCK = {}.freeze
  KIND = :element_type.freeze

  enum kind: KINDS

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

  def move(to)
    super(to, container.elements_positions)
  end

  def template_representation(publish_mode = false)
    template_model.new(self, publish_mode)
  end

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

  private

  def reorder
    positions = container.elements_positions(id: :desc)
    save_position_changes(positions)
  end

  def set_defaults
    self.kind = self.class::KIND
    update_attrs(block: self.class::DEFAULT_BLOCK)
  end

  def template_model
    case kind.to_sym
    when :link
      Representation::ElementLinkTemplate
    when :text, :image
      Representation::ElementTemplate
    else
      raise(BlogCreatorError, "Unknown element kind \"#{kind}\"")
    end
  end
end
