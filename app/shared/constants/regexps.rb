# frozen_string_literal: true

module Constants
  module Regexps
    URL = URI::DEFAULT_PARSER.make_regexp
    EMAIL = URI::MailTo::EMAIL_REGEXP
  end
end
