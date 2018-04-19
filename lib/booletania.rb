require "booletania/version"
require "booletania/method"
require "booletania/attribute"

module Booletania
  extend ActiveSupport::Concern

  included do
    raise ArgumentError, "booletania only support ActiveRecord" unless ancestors.include? ActiveRecord::Base
  end

  class_methods do
    def booletania_columns(*columns)
      Booletania::Attribute.define_methods!(self, columns)
    end
  end
end
