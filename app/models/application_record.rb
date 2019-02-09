# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  OPTIONAL_URL_FORMATTER = {
    with: Constants::Regexps::URL,
    allow_blank: true
  }.freeze
end
