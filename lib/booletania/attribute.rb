module Booletania
  class Attribute
    class << self
      def define_methods!(klass, boolean_columns)
        boolean_columns.each do |boolean_column|
          column_obj = Booletania::Column.new(klass, boolean_column)

          define_attribute_text(column_obj)

          define_attribute_options(column_obj)
        end
      end

      private

      def define_attribute_text(column_obj)
        column_obj.klass.class_eval column_obj._text, __FILE__, __LINE__ + 1
      end

      def define_attribute_options(column_obj)
        column_obj.klass.instance_eval column_obj._options, __FILE__, __LINE__ + 1
      end
    end
  end
end
