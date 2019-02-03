# string :offset_top
# string :offset_right
# string :offset_bottom
# string :offset_left
# string :bg_color
# string :bg_image
# integer :post_id
# integer :position
class Container < ApplicationRecord
  include SharedModels::PositionableModel

  after_create :reorder
  after_destroy :reorder

  belongs_to :post
  has_many :elements, dependent: :destroy

  defaults(
    offset_top: '20px',
    offset_right: '5%',
    offset_bottom: '20px',
    offset_left: '5%'
  )

  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :position, POSITION_VALIDATIONS
  validates :post_id, presence: true

  def capture_attrs
    attributes
  end

  def move(to)
    super to, post.containers_positions
  end

  def elements_positions(*also_order_by)
    elements.order(:position, *also_order_by).map(&:position_representation)
  end

  private

  def reorder
    positions = post.containers_positions(id: :desc)
    save_position_changes positions
  end
end
