Types::CorpusType = GraphQL::ObjectType.define do
  name "Corpus"

  field :id, !types.ID
  field :link, types.String
  field :slug, !types.String
  field :title, !types.String
  field :works,
        function: Functions::Pagination.new(children: :works, type: types[Types::WorkType])
end
