# frozen_string_literal: true

class ApplicationViewModel
  attr_accessor :model, :publish_mode

  def initialize(model)
    self.model = model
    collect_model_attrs(permitted_model_attrs)
  end

  def attributes=(attributes)
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def collect_model_attrs(attrs)
    attrs.each do |name|
      self.class.attr_accessor(name.to_sym)
      value = model.send(name)
      send(name.to_s + '=', value)
    end
  end

  def render(params)
    ApplicationController.render(params)
  end

  protected

  def permitted_model_attrs
    []
  end
end
