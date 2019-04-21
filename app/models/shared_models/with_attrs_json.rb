# frozen_string_literal: true

module SharedModels
  module WithAttrsJson
    def update_attrs!(changes)
      update!(attrs: attrs.deep_merge(changes))
    end
  end
end