Types::TextNodeType = GraphQL::ObjectType.define do
  name "TextNode"

  field :id, !types.ID
  field :index, !types.Int
  field :location, !types[types.Int]
  field :data, Types::JsonType
  field :entity_ranges, types[Types::JsonType]
  field :inline_style_ranges, types[Types::JsonType]
  field :text_node_type, !types.String
  field :key, !types.String
  field :text, types.String
end
