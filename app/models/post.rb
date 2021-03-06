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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  blog_id     :integer          not null
#
# Indexes
#
#  index_posts_on_blog_id  (blog_id)
#

class Post < ApplicationRecord
  include SharedModels::WithAttrsJson

  before_create :set_defaults

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

  def publish
    PostWorker::Publish.perform_async(id)
  end

  def unpublish
    raise(BlogCreatorError, 'Post is not published') unless published

    PostWorker::Unpublish.perform_async(id)
  end

  def published_dir_path
    "#{blog.published_dir_path}/posts/#{id}"
  end

  def published_page_path
    "#{published_dir_path}/index.html"
  end

  def physical_dir_path
    "#{blog.physical_dir_path}/posts/#{id}"
  end

  private

  def set_defaults
    attrs['thumbnail'] = Config::Images::PLACEHOLDER
  end
end
