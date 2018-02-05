require "booletania/version"
require "booletania/method"
require "booletania/attribute"

module Booletania
  extend ActiveSupport::Concern

  included do
    raise ArgumentError, "booletania only support ActiveRecord" unless ancestors.include? ActiveRecord::Base
    raise ArgumentError, "not found .columns method" unless respond_to? :columns

    Booletania::Attribute.define_methods!(self, columns.select{ |column| column.type == :boolean })
  end
end
