# frozen_string_literal: true

# == Schema Information
#
# Table name: containers
#
#  id            :bigint(8)        not null, primary key
#  bg_color      :string           default("#FFF")
#  bg_image      :string
#  post_id       :integer          not null
#  position      :integer          not null
#  offset_top    :integer          default(20)
#  offset_right  :integer          default(10)
#  offset_bottom :integer          default(20)
#  offset_left   :integer          default(10)
#

class Container < ApplicationRecord
  include SharedModels::PositionableModel

  after_create :reorder
  after_destroy :reorder

  belongs_to :post
  has_many :elements, dependent: :destroy

  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :position, POSITION_VALIDATIONS
  validates :post_id, presence: true

  def capture_attrs
    attrs = attributes
    attrs['elements'] = elements.order(:position)
    attrs
  end

  def move(to)
    super to, post.containers_positions
  end

  def elements_positions(*also_order_by)
    elements_with_order(*also_order_by).map(&:position_representation)
  end

  def elements_with_order(*also_order_by)
    elements.order(:position, *also_order_by)
  end

  def template_representation(publish_mode = false)
    Representation::ContainerTemplate.new self, publish_mode
  end

  private

  def reorder
    positions = post.containers_positions(id: :desc)
    save_position_changes positions
  end
end
