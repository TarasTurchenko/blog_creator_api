# frozen_string_literal: true

# == Schema Information
#
# Table name: containers
#
#  id       :bigint(8)        not null, primary key
#  attrs    :jsonb
#  position :integer          not null
#  post_id  :integer          not null
#
# Indexes
#
#  index_containers_on_post_id  (post_id)
#

class Container < ApplicationRecord
  include SharedModels::PositionableModel
  include SharedModels::WithAttrsJson

  MAX_ELEMENTS_COUNT = 2

  after_create :reorder
  after_destroy :reorder

  belongs_to :post
  has_many :elements, dependent: :destroy

  validates :position, POSITION_VALIDATIONS
  validates :post_id, presence: true

  def move(to)
    super(Element, to, post.containers_positions)
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
    save_position_changes(Container, positions)
  end
end
