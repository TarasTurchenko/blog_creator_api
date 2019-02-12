# frozen_string_literal: true

module Representation
  class Base
    def attributes=(attributes)
      attributes.each do |name, value|
        setter = "#{name}="
        self.send(setter, value)
      end
    end
  end
end