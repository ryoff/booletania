module Booletania
  class Attribute
    def self.define_methods!(mod, boolean_columns)
      boolean_columns.each do |boolean_column|
        mod.module_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{boolean_column.name}_text
            # http://yaml.org/type/bool.html
            I18n.t "booletania.#{mod.name.underscore}.#{boolean_column.name}." + #{boolean_column.name}.__send__(:to_s), default: #{boolean_column.name}.__send__(:to_s)
          end
        RUBY
      end
      boolean_columns
    end
  end
end
