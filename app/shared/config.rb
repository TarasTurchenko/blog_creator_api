# frozen_string_literal: true

module Config
  module Images
    PLACEHOLDER = 'placeholder.png'
  end

  module Regexps
    URL = URI::DEFAULT_PARSER.make_regexp
    EMAIL = URI::MailTo::EMAIL_REGEXP
  end

  module Auth
    TOKEN_ENCRYPTION = 'HS256'
  end
end
