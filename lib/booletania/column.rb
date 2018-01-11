module Booletania
  class Column
    attr_reader :klass, :boolean_column

    def initialize(klass, boolean_column)
      @klass = klass
      @boolean_column = boolean_column
    end

    def booletania_i18n_path
      "booletania.#{klass.name.underscore}.#{boolean_column.name}"
    end

    def _text
      <<-RUBY
        def #{boolean_column.name}_text
          I18n.t "#{booletania_i18n_path}." + #{boolean_column.name}.__send__(:to_s), default: #{boolean_column.name}.__send__(:to_s)
        end
      RUBY
    end

    def _options
      <<-RUBY
        def #{boolean_column.name}_options
          (I18n.t "#{booletania_i18n_path}", default: {}).invert.map { |k, v| [k, v.to_b] }
        end
      RUBY
    end
  end
end
