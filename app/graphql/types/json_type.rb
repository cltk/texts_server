Types::JsonType = GraphQL::ScalarType.define do
  name "JSON"

  coerce_input -> (json, ctx) { JSON.parse(json) }
  coerce_result -> (json, ctx) { JSON.dump(json) }
end
