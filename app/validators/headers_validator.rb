# frozen_string_literal: true

class HeadersValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    unless hash?(value)
      record.errors.add(attribute, 'has to be a valid hash')
      return
    end

    unless unique?(value)
      record.errors.add(attribute, 'has duplicate keys')
      return
    end

    return if valid?(value)

    record.errors.add(attribute, 'is invalid')
  end

  private

  def hash?(value)
    value.is_a?(Hash)
  end

  def unique?(value)
    value.keys.size == value.transform_keys(&:downcase).size
  end

  def valid?(value)
    value.each do |key, hash_value|
      return false if !key.match?(key_regexp) || !hash_value.match?(value_regexp)
    end
    true
  end

  def key_regexp
    /^[a-zA-Z0-9+_-]*$/
  end

  def value_regexp
    %r{^[a-zA-Z0-9_:;,./"'?!(){}\[\]@<>=\-+*\#$&`|~^% ]*$}
  end
end
