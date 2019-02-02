# frozen_string_literal: true

# string :title
# boolean :published
# string :offset_top
# string :offset_right
# string :offset_bottom
# string :offset_left
# string :bg_color
# string :bg_image
# string :thumbnail
# integer :blog_id
class Post < ApplicationRecord
  belongs_to :blog
  has_many :containers, dependent: :destroy

  defaults(
    published: false,
    thumbnail: Constants::Images::PLACEHOLDER,
    offset_top: '20px',
    offset_right: '5%',
    offset_bottom: '20px',
    offset_left: '5%'
  )

  validates :title, presence: true
  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :thumbnail, format: OPTIONAL_URL_FORMATTER
  validates :blog_id, presence: true

  def short_attrs
    {
      id: id,
      published: published,
      title: title
    }
  end

  def capture_attrs
    attrs = attributes
    attrs['blog'] = blog.attributes
    attrs['containers'] = containers.order(:position).map(&:capture_attrs)
    attrs
  end

  def prepare_for_blog_preview
    {
      id: id,
      title: title,
      thumbnail: thumbnail
    }
  end

  def containers_positions(*also_order_by)
    containers.order(:position, *also_order_by).map(&:position_representation)
  end
end
