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
        "(index >= (
               select index - :leading_nodes from text_nodes
               where work_id = :work_id and location = ARRAY[:location]
        ) and index < (
              select index from text_nodes
              where work_id = :work_id and location = ARRAY[:location]
        )) or (index <= (
               select index + :trailing_nodes from text_nodes
               where work_id = :work_id and location = ARRAY[:location]
        ) and index >= (
              select index from text_nodes
              where work_id = :work_id and location = ARRAY[:location]
        ))",
        leading_nodes: args[:leading_nodes],
        location: args[:location],
        trailing_nodes: args[:trailing_nodes],
        work_id: obj.id
      ).order(index: :asc)
    end
  end
end
