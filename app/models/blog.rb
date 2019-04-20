# frozen_string_literal: true
# == Schema Information
#
# Table name: blogs
#
#  id        :bigint(8)        not null, primary key
#  author    :string           not null
#  name      :string           not null
#  published :boolean          default(FALSE)
#  user_id   :bigint(8)
#
# Indexes
#
#  index_blogs_on_user_id  (user_id)
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

  def template_representation(publish_mode = false)
    Representation::BlogTemplate.new(self, publish_mode)
  end

  def publish
    Services::BlogPublisher.new(self).publish
  end
end
