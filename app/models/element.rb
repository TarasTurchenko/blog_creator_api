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

  MAX_SIZE = 12

  KINDS = %i[text image link].freeze

  LINK_DESTINATION_TYPES = %w[external homepage post].freeze

  TEMPLATE_MODELS = {
    'link' => Representation::ElementLinkTemplate
  }.freeze

  before_create :set_defaults
  after_create :reorder
  after_destroy :reorder

  belongs_to :container

  enum kind: KINDS

  validates :container_id, presence: true
  validates :size, presence: true, numericality: {
    only_integer: true, greater_than: 0,
    less_than_or_equal_to: MAX_SIZE
  }
  validates :kind, presence: true, inclusion: { in: kinds }
  validates :position, POSITION_VALIDATIONS

  def move(to)
    super to, container.elements_positions
  end

  def template_representation(publish_mode = false)
    template_model.new self, publish_mode
  end

  private

  def reorder
    positions = container.elements_positions(id: :desc)
    save_position_changes positions
  end

  def set_defaults
    defaults = { block: Elements::Defaults::BLOCK[kind] }
    update_attrs defaults
  end

  def template_model
    TEMPLATE_MODELS[kind] || Representation::ElementTemplate
  end
end
