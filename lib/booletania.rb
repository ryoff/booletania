require "booletania/version"
require "booletania/method"
require "booletania/attribute"

module Booletania
  extend ActiveSupport::Concern

  included do
    fail ArgumentError, "booletania only support ActiveRecord" unless ancestors.include? ActiveRecord::Base
    fail ArgumentError, "not found .columns method" unless respond_to? :columns

    Booletania::Attribute.define_methods!(self, columns.select{ |column| column.type == :boolean })
  end
end
