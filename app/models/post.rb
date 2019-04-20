# frozen_string_literal: true
# == Schema Information
#
# Table name: posts
#
#  id          :bigint(8)        not null, primary key
#  attrs       :jsonb
#  description :string
#  published   :boolean          default(FALSE)
#  title       :string           not null
#  blog_id     :integer          not null
#
# Indexes
#
#  index_posts_on_blog_id  (blog_id)
#

class Post < ApplicationRecord
  include SharedModels::WithAttrsJson

  belongs_to :blog
  has_many :containers, dependent: :destroy

  validates :title, presence: true
  validates :blog_id, presence: true

  def run_destroy_worker
    PostWorker::Destroy.perform_async(id)
  end

  def containers_positions(*also_order_by)
    containers_with_order(*also_order_by).map(&:position_representation)
  end

  def containers_with_order(*also_order_by)
    containers.order(:position, *also_order_by)
  end

  def template_representation(publish_mode = false)
    Representation::PostTemplate.new(self, publish_mode)
  end

  def publish
    Services::PostPublisher.new(self).publish
  end

  def unpublish
    raise BlogCreatorError.new('Post already unpublished') unless published

    Services::PostPublisher.new(self).unpublish
  end
end
