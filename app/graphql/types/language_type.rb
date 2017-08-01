Types::LanguageType = GraphQL::ObjectType.define do
  name "Language"
  
  field :id, !types.ID
  field :authors, types[Types::AuthorType]
  field :corpora, types[Types::CorpusType]
  field :slug, !types.String
  field :title, !types.String
  field :works,
        function: Functions::Pagination.new(children: :works, type: types[Types::WorkType])
end
