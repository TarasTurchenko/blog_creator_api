# frozen_string_literal: true

module SharedModels
  module PositionableModel
    POSITION_VALIDATIONS = {
      presence: true,
      numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    }.freeze

    def position_representation
      { id: id, position: position }
    end

    def save_position_changes(positions)
      changes = positions_changes positions
      ids = changes.map { |changed| changed[:id] }
      values = changes.map { |changed| { position: changed[:position] } }
      self.class.update ids, values
      changes
    end

    private

    def positions_changes(positions)
      initial = positions.map(&:clone)
      updated = positions.map.with_index do |model, index|
        model[:position] = index
        model
      end
      updated - initial
    end
  end
end