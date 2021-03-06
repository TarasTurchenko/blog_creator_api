# frozen_string_literal: true

# == Schema Information
#
# Table name: blogs
#
#  id        :bigint(8)        not null, primary key
#  author    :string           not null
#  name      :string           not null
#  published :boolean          default(FALSE)
#  subdomain :string           not null
#  user_id   :bigint(8)
#
# Indexes
#
#  index_blogs_on_subdomain  (subdomain) UNIQUE
#  index_blogs_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Blog < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :author, presence: true

  def published_posts
    posts.where(published: true)
  end

  def publish
    BlogWorker::Publish.perform_async(id)
  end

  def published_dir_path
    '/' + subdomain
  end

  def published_page_path
    "#{published_dir_path}/index.html"
  end

  def physical_dir_path
    "blogs/#{subdomain}"
  end
end
