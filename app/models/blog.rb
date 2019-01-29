# frozen_string_literal: true

# string :name
# string :author
# boolean :published
class Blog < ApplicationRecord
  before_create :set_default_values

  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :author, presence: true

  private

  def set_default_values
    self.published ||= false
  end
end
