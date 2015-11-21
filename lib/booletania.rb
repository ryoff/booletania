require "booletania/version"
require "booletania/attribute"

module Booletania
  extend ActiveSupport::Concern

  included do
    Attribute.define_methods!(self, columns.select{ |column| column.type == :boolean })
  end
end
