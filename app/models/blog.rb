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
end
