# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id            :bigint(8)        not null, primary key
#  title         :string           not null
#  published     :boolean          default(FALSE)
#  bg_color      :string           default("#FFF")
#  bg_image      :string
#  thumbnail     :string
#  blog_id       :integer          not null
#  description   :string
#  offset_top    :integer
#  offset_right  :integer
#  offset_bottom :integer
#  offset_left   :integer
#

class Post < ApplicationRecord
  belongs_to :blog
  has_many :containers, dependent: :destroy

  before_create :set_defaults

  validates :title, presence: true
  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :thumbnail, format: OPTIONAL_URL_FORMATTER
  validates :blog_id, presence: true

  def capture_attrs
    attrs = attributes
    attrs['blog'] = blog.attributes
    attrs['containers'] = containers_with_order.map(&:capture_attrs)
    attrs
  end

  def containers_positions(*also_order_by)
    containers_with_order(*also_order_by).map(&:position_representation)
  end

  def containers_with_order(*also_order_by)
    containers.order(:position, *also_order_by)
  end

  def template_representation(publish_mode = false)
    Representation::PostTemplate.new self, publish_mode
  end

  def publish
    publisher = Services::PostPublisher.new(self)
    publisher.publish
    update!(published: true) unless published

    blog.sync_homepage

    publisher.page_url
  end

  def unpublish
    raise BlogCreatorError.new('Post already unpublished') unless published

    publisher = Services::PostPublisher.new(self)
    publisher.unpublish
    update! published: false

    blog.sync_homepage
  end

  private

  def set_defaults
    self.thumbnail ||= Constants::Images::PLACEHOLDER
  end

  def generate_unique_key
    Digest::MD5.hexdigest "#{id}_#{DateTime.now}"
  end
end
