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

  def template_representation
    Representation::BlogTemplate.new self
  end

  def publish
    publisher = Services::BlogPublisher.new(self)
    publisher.publish
    publisher.reset_cdn_caches
    update!(published: true) unless published

    Helpers::Aws.build_cdn_url("blogs/#{id}/index.html")
  end
end
