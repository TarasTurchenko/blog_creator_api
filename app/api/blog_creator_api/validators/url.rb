# frozen_string_literal: true

module BlogCreatorApi
  module Validators
    class Url < Validators::Base
      def validate_param!(attr_name, params)
        unless params[attr_name] =~ Constants::Regexps::URL
          reject attr_name, 'is not valid URL'
        end
      end
    end
  end
end
