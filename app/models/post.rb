# frozen_string_literal: true
# == Schema Information
#
# Table name: posts
#
#  id            :bigint(8)        not null, primary key
#  bg_color      :string           default("#FFF")
#  bg_image      :string
#  description   :string
#  offset_bottom :string
#  offset_left   :string
#  offset_right  :string
#  offset_top    :string
#  published     :boolean          default(FALSE)
#  thumbnail     :string
#  title         :string           not null
#  blog_id       :integer          not null
#
# Indexes
#
#  index_posts_on_blog_id  (blog_id)
#

class Post < ApplicationRecord
  belongs_to :blog
  has_many :containers, dependent: :destroy

  before_create

  validates :title, presence: true
  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :thumbnail, format: OPTIONAL_URL_FORMATTER
  validates :blog_id, presence: true

  def short_attrs
    {
      id: id,
      title: title,
      published: published,
      thumbnail: thumbnail,
      description: description
    }
  end

  def capture_attrs
    attrs = attributes
    attrs['blog'] = blog.attributes
    attrs['containers'] = containers.order(:position).map(&:capture_attrs)
    attrs
  end

  def containers_positions(*also_order_by)
    containers.order(:position, *also_order_by).map(&:position_representation)
  end

  private

  def set_defaults
    self.thumbnail ||= Constants::Images::PLACEHOLDER
  end
end
