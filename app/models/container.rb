# string :offset_top
# string :offset_right
# string :offset_bottom
# string :offset_left
# string :bg_color
# string :bg_image
# integer :post_id
# integer :position
class Container < ApplicationRecord
  before_create :set_default_values

  belongs_to :post

  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :position, presence: true

  def capture_attrs
    attributes
  end

  private

  def set_default_values
    self.offset_top ||= '20px'
    self.offset_right ||= '5%'
    self.offset_bottom ||= '20px'
    self.offset_left ||= '5%'
  end
end
