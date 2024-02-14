module Booletania
  class Method
    attr_reader :klass, :boolean_column_name

    def initialize(klass, boolean_column_name)
      @klass = klass
      @boolean_column_name = boolean_column_name
    end

    def _text
      i18n_true_keys = i18n_keys(true) + [true.to_s.humanize]
      i18n_false_keys = i18n_keys(false) + [false.to_s.humanize]
      <<-RUBY
        def #{boolean_column_name}_text
          keys = #{boolean_column_name}? ? #{i18n_true_keys} : #{i18n_false_keys}

          I18n.t(keys[0], default: keys[1..-1])
        end
      RUBY
    end

    def _options
      path_keys = i18n_path_keys + [{}]
      <<-RUBY
        def #{boolean_column_name}_options
          I18n.t("#{path_keys[0]}", default: #{path_keys[1..-1]}).invert.map { |k, v| [k, v.to_s.downcase == 'true' ? true : false] }
        end
      RUBY
    end

    private

    # For example,
    #   [
    #     :booletania.invitation.accepted.true,
    #     :activerecord.attributes.invitation/accepted.true
    #   ]
    # For example,
    #   [
    #     :booletania.invitation.accepted.false,
    #     :activerecord.attributes.invitation/accepted.false
    #   ]
    def i18n_keys(true_or_false)
      i18n_path_keys.map do |i18n_path_key|
        (i18n_path_key.to_s + '.' + true_or_false.to_s).to_sym
      end
    end

    def i18n_path_keys
      @i18n_path_keys ||= begin
        [].tap do |list|
          list << booletania_i18n_path_key
          list << activerecord_i18n_path_key
          list
        end
      end
    end

    # For example, :booletania.invitation.accepted
    def booletania_i18n_path_key
      :"booletania.#{klass.name.underscore}.#{boolean_column_name}"
    end

    # For example, :activerecord.attributes.invitation/accepted
    def activerecord_i18n_path_key
      :"activerecord.attributes.#{klass.name.underscore}/#{boolean_column_name}"
    end
  end
end
