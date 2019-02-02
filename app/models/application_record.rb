class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  OPTIONAL_URL_FORMATTER = { with: Constants::Regexps::URL, allow_blank: true }

  after_initialize :set_default_values

  def self.defaults(attributes)
    @defaults = saved_defaults.merge(attributes)
  end

  def self.saved_defaults
    @defaults || {}
  end

  private

  def set_default_values
    if new_record?
      self.class.saved_defaults.each { |attr, value| self[attr] ||= value }
    end
  end
end
