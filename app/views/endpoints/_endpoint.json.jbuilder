# frozen_string_literal: true

json.id EndpointDecorator.new(endpoint).string_id
json.type 'endpoints'
json.attributes do
  json.path endpoint.path
  json.verb endpoint.verb
  json.response do
    json.code endpoint.code
    json.headers endpoint.headers
    json.body endpoint.body
  end
end
