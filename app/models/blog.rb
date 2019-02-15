# frozen_string_literal: true
# == Schema Information
#
# Table name: blogs
#
#  id          :bigint(8)        not null, primary key
#  author      :string           not null
#  name        :string           not null
#  publish_key :string
#  published   :boolean          default(FALSE)
#
# Indexes
#
#  index_blogs_on_publish_key  (publish_key) UNIQUE
#

class Blog < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :author, presence: true
  validates :publish_key, uniqueness: true

  after_create :set_publish_key

  def published_posts
    posts.where(published: true)
  end

  def template_representation
    Representation::BlogTemplate.new self
  end

  def publish
    publisher = Services::BlogPublisher.new(self)
    publisher.publish
    publisher.reset_cdn_caches
    update!(published: true) unless published

    build_cdn_url
  end

  def build_cdn_url
    "#{ENV['CDN_URL']}/blogs/#{publish_key}/index.html"
  end

  private

  def set_publish_key
    update! publish_key: generate_unique_key
  end

  def generate_unique_key
    Digest::MD5.hexdigest "#{id}_#{DateTime.now}"
  end
end
