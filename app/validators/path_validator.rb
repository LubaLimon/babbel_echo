# frozen_string_literal: true

class PathValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?
    return if value.match?(regexp)

    record.errors.add(attribute, 'is invalid')
  end

  private

  def regexp
    %r{^/[a-zA-Z0-9.-_~!$&()*+,;=:@?%]*$} # RFC 3986 path validation
  end
end
