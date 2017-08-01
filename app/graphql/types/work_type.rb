Types::WorkType = GraphQL::ObjectType.define do
  name "Work"

  field :id, !types.ID
  field :english_title, types.String
  field :form, types.String
  field :original_title, !types.String
  field :slug, !types.String
  field :structure, types.String
  field :urn, types.String
  field :text_nodes,
        function: Functions::Pagination.new(children: :text_nodes, type: types[Types::TextNodeType])
end
