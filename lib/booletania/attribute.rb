module Booletania
  class Attribute
    class << self
      def define_methods!(klass, boolean_columns)
        boolean_columns.each do |boolean_column|
          i18n_attribute_path = booletania_i18n_path(klass, boolean_column)

          define_attribute_text(klass, boolean_column, i18n_attribute_path)

          define_attribute_options(klass, boolean_column, i18n_attribute_path)
        end
      end

      private

      def define_attribute_text(klass, boolean_column, i18n_attribute_path)
        klass.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{boolean_column.name}_text
            # http://yaml.org/type/bool.html
            I18n.t "#{i18n_attribute_path}." + #{boolean_column.name}.__send__(:to_s), default: #{boolean_column.name}.__send__(:to_s)
          end
        RUBY
      end

      def define_attribute_options(klass, boolean_column, i18n_attribute_path)
        klass.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def self.#{boolean_column.name}_options
            (I18n.t "#{i18n_attribute_path}", default: {}).invert.map { |k, v| [k, v.to_b] }
          end
        RUBY
      end

      def booletania_i18n_path(klass, boolean_column)
        "booletania.#{klass.name.underscore}.#{boolean_column.name}"
      end
    end
  end
end
