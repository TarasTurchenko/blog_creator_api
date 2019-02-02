# frozen_string_literal: true

# string :name
# string :author
# boolean :published
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
    posts.where(published: true).order(id: :desc).map(&:prepare_for_blog_preview)
  end

  def set_default_values
    self.published ||= false
  end
end
