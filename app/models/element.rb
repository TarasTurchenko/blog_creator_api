# frozen_string_literal: true

# integer :container_id
# string :offset_top
# string :offset_right
# string :offset_bottom
# string :offset_left
# string :bg_image
# string :bg_color
# integer :size
# integer :position
# string :kind
# jsonb :main_settings
class Element < ApplicationRecord
  include SharedModels::PositionableModel

  MAX_SIZE = 12
  DEFAULTS = {
    text: { content: 'Hey! Your text will be here' }.freeze,
    image: {
      src: Constants::Images::PLACEHOLDER,
      alt: 'Placeholder image'
    }.freeze,
    link: {
      kind: :external,
      destination: 'http://example-link.com'
    }.freeze
  }.freeze

  belongs_to :container

  enum kind: %i(text image link)

  validates :container_id, presence: true
  validates :bg_image, format: OPTIONAL_URL_FORMATTER
  validates :size, presence: true, numericality: {
    only_integer: true, greater_than: 0,
    less_than_or_equal_to: MAX_SIZE
  }
  validates :kind, presence: true, inclusion: { in: kinds }
  validates :position, POSITION_VALIDATIONS

  private

  def set_default_values
    self.offset_top ||= '20px'
    self.offset_right ||= '5%'
    self.offset_bottom ||= '20px'
    self.offset_left ||= '5%'
    self.main_settings ||= DEFAULTS[kind.to_sym]
  end
end
