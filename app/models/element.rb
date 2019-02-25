# frozen_string_literal: true

# == Schema Information
#
# Table name: elements
#
#  id            :bigint(8)        not null, primary key
#  bg_color      :string           default("#FFF")
#  bg_image      :string
#  kind          :integer          not null
#  main_settings :jsonb
#  offset_bottom :string           default("5px")
#  offset_left   :string           default("5px")
#  offset_right  :string           default("5px")
#  offset_top    :string           default("5px")
#  position      :integer          not null
#  size          :integer          not null
#  container_id  :integer          not null
#
# Indexes
#
#  index_elements_on_container_id  (container_id)
#

class Element < ApplicationRecord
  self.table_name = :elements

  include SharedModels::PositionableModel

  MAX_SIZE = 12

  KINDS = %i[blank text image link].freeze

  DEFAULT_SETTINGS = {
    'blank' => {}.freeze,
    'text' => { content: 'Hey! Your text will be here' }.freeze,
    'image' => {
      src: Constants::Images::PLACEHOLDER,
      alt: 'Placeholder image'
    }.freeze,
    'link' => {
      destination_type: 'external',
      destination: 'http://example-link.com',
      text: 'Example link'
    }.freeze
  }.freeze

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
  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :size, presence: true, numericality: {
    only_integer: true, greater_than: 0,
    less_than_or_equal_to: MAX_SIZE
  }
  validates :kind, presence: true, inclusion: { in: kinds }
  validates :position, POSITION_VALIDATIONS

  def move(to)
    super to, container.elements_positions
  end

  def update_main_settings(changes)
    old = main_settings
    self.main_settings = old.merge changes
  end

  def self.update_sizes(sizes)
    keys = sizes.map { |element| element[:id].to_i }
    sizes_list = sizes.map { |element| { size: element[:size] } }
    Element.update keys, sizes_list
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
    self.main_settings ||= DEFAULT_SETTINGS[kind]
  end

  def template_model
    TEMPLATE_MODELS[kind] || Representation::ElementTemplate
  end
end
