# frozen_string_literal: true

class HtmlSanitizer
  ALLOWED_TAGS = %w[b i u strike sub sup div span blockquote ul ol li h1 h2 h3
                    h4 h5 h6 br font a hr].freeze
  ALLOWED_ATTRIBUTES = %w[style size face color href target].freeze

  attr_accessor :source, :sanitizer

  def initialize(html)
    self.source = html
    self.sanitizer = Rails::Html::WhiteListSanitizer.new
  end

  def sanitize
    config = { tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES }
    sanitizer.sanitize(source, config)
  end
end
