Types::AuthorType = GraphQL::ObjectType.define do
  name "Author"

  field :id, !types.ID
  field :name, !types.String
  field :slug, !types.String
  field :works,
        function: Functions::Pagination.new(children: :works, type: types[Types::WorkType])
  field :work_by_id, Types::WorkType do
    argument :id, !types.ID

    description "Find a work by this author with the given (integer) ID"
    resolve -> (obj, args, ctx) do
      Work.find_by(author_id: obj.id, id: args[:id].to_i)
    end
  end
  field :work_by_slug, Types::WorkType do
    argument :slug, !types.String

    description "Find a work by this author with the given slug"
    resolve -> (obj, args, ctx) { Work.find_by(author_id: obj.id, slug: args[:slug]) }
  end
end
