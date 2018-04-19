require "booletania/version"
require "booletania/method"
require "booletania/attribute"

module Booletania
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      raise ArgumentError, "booletania only support ActiveRecord" unless ancestors.include? ActiveRecord::Base
    end
  end

  module ClassMethods
    def booletania_columns(*columns)
      Booletania::Attribute.define_methods!(self, columns)
    end
  end
end
