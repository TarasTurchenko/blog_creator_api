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

  def capture_preview_attrs
    attrs = attributes
    attrs['posts'] = capture_posts_data
    attrs['last_post'] = attrs['posts'].delete_at(0)
    attrs
  end

  private

  def capture_posts_data
    posts.where(published: true).order(id: :desc).map(&:short_attrs)
  end
end
