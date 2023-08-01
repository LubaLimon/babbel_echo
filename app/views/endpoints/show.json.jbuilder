# frozen_string_literal: true

json.data do
  json.partial! 'endpoints/endpoint', endpoint: @endpoint
end
