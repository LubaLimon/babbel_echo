# frozen_string_literal: true

json.errors @errors do |error|
  json.code error.code
  json.detail error.detail
end
