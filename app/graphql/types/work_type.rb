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
  field :text_nodes_by_location, types[Types::TextNodeType] do
    description "Find TextNodes using the location array"

    argument :leading_nodes,
             types.Int,
             "Number of nodes before given location (limit: 30)",
             default_value: 10,
             prepare: -> (n, ctx) { [n, 30].min }
    argument :location, !types[!types.Int]
    argument :trailing_nodes,
             types.Int,
             "Number of nodes before given location (limit: 30)",
             default_value: 10,
             prepare: -> (n, ctx) { [n, 30].min }

    resolve -> (obj, args, ctx) do
      obj.text_nodes.where(
        "location[array_length(location, 1)] <= ?
         and location[array_length(location, 1)] >= ?",
        args[:location][args[:location].length - 1] + args[:trailing_nodes],
        args[:location][args[:location].length - 1] - args[:leading_nodes] 
      ).order(index: :asc)
    end
  end
end
