# frozen_string_literal: true

# == Schema Information
#
# Table name: blogs
#
#  id        :bigint(8)        not null, primary key
#  author    :string           not null
#  name      :string           not null
#  published :boolean          default(FALSE)
#

class Blog < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :author, presence: true

  def published_posts
    posts.where(published: true)
  end

  def template_representation(publish_mode = false)
    Representation::BlogTemplate.new self, publish_mode
  end

  def publish
    publisher = Services::BlogPublisher.new(self)
    publisher.publish
    publisher.reset_cdn_caches
    update!(published: true) unless published

    publisher.page_url
  end

  def sync_homepage
    publisher = Services::BlogPublisher.new(self)
    publisher.publish if published
    publisher.reset_cdn_caches
  end

  def unpublish
    raise BlogCreatorError.new('Blog already unpublished') unless published

    publisher = Services::BlogPublisher.new(self)
    publisher.unpublish
    publisher.reset_cdn_caches

    update! published: false
    posts.update_all published: false
  end
end
