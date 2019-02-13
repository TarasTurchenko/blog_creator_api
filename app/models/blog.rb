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

  after_create :generate_publish_key

  def published_posts
    posts.where(published: true)
  end

  def template_representation
    Representation::BlogTemplate.new self
  end

  def publish
    publisher = Services::BlogPublished.new( self)
    publisher.publish

    if published
      publisher.reset_cdn_caches
    else
      update! published: true
    end

    build_cdn_url
  end

  def build_cdn_url
    "#{ENV['CDN_URL']}/blogs/#{publish_key}/index.html"
  end

  private

  def generate_publish_key
    key = Digest::MD5.hexdigest "#{id}_#{DateTime.now}"
    update! publish_key: key
  end
end
