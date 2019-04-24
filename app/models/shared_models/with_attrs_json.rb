# frozen_string_literal: true

module SharedModels
  module WithAttrsJson
    def update_attrs!(changes)
      update!(attrs: attrs.deep_merge(changes.deep_stringify_keys))
    end
  end
end