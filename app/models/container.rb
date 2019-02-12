# frozen_string_literal: true

# == Schema Information
#
# Table name: containers
#
#  id            :bigint(8)        not null, primary key
#  bg_color      :string           default("#FFF")
#  bg_image      :string
#  offset_bottom :string           default("20px")
#  offset_left   :string           default("10%")
#  offset_right  :string           default("10%")
#  offset_top    :string           default("20px")
#  position      :integer          not null
#  post_id       :integer          not null
#
# Indexes
#
#  index_containers_on_post_id  (post_id)
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

  private

  def reorder
    positions = post.containers_positions(id: :desc)
    save_position_changes positions
  end
end
