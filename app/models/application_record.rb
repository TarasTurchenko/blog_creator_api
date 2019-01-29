class ApplicationRecord < ActiveRecord::Base
  OPTIONAL_URL_FORMATTER = { with: Constants::Regexps::URL, allow_blank: true }

  self.abstract_class = true
end
