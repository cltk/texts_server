Types::WorkType = GraphQL::ObjectType.define do
  name "Work"

  field :id, !types.ID
  field :author, !Types::AuthorType
  field :corpus, !Types::CorpusType
  field :language, !Types::LanguageType
  field :english_title, types.String
  field :form, types.String
  field :original_title, !types.String
  field :slug, !types.String
  field :structure, types.String
  field :urn, types.String
  field :text_nodes, types[Types::TextNodeType] do
    description "Find TextNodes using the location array"

    argument :leading_nodes,
             types.Int,
             "Number of nodes before given location (limit: 30)",
             default_value: 10,
             prepare: -> (n, ctx) { [n, 30].min }
    argument :location, types[types.Int]
    argument :trailing_nodes,
             types.Int,
             "Number of nodes before given location (limit: 30)",
             default_value: 10,
             prepare: -> (n, ctx) { [n, 30].min }

    resolve -> (obj, args, ctx) do
      if args[:location]
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
      else
        obj.text_nodes.order(index: :asc).limit(30)
      end
    end
  end
  field :text_location_next, types[types.Int] do
    description "Find the next text node ahead of the supplied location at a given offset"
    argument :location, types[types.Int]
    argument :offset,
             types.Int,
             "Number of nodes to offset forward",
             default_value: 20,
             prepare: -> (n, ctx) { [n, 30].min }
    resolve -> (obj, args, ctx) do
      if args[:location]
        current_text_node = obj.text_nodes.where(
	        work_id: obj.id,
					location: args[:location],
	      ).order(index: :asc).first
			else
        current_text_node = obj.text_nodes.where(
	        work_id: obj.id,
	      ).order(index: :asc).first
			end


			next_text_node = obj.text_nodes.where(
        "(
					index >= :current_text_node_index
	      and
					index <= :current_text_node_index + :offset
        )",
				current_text_node_index: current_text_node.index,
				offset: args[:offset],
			).order(index: :asc).last

			if next_text_node
				next_text_node.location
			else
				[]
			end
		end
	end
	field :text_location_prev, types[types.Int] do
    description "Find the next text node before the supplied location at a given offset"
    argument :location, types[types.Int]
    argument :offset,
             types.Int,
             "Number of nodes to offset before the target location",
             default_value: 20,
             prepare: -> (n, ctx) { [n, 30].min }
    resolve -> (obj, args, ctx) do
      if args[:location]
        current_text_node = obj.text_nodes.where(
	        work_id: obj.id,
					location: args[:location],
	      ).order(index: :asc).first
			else
        current_text_node = obj.text_nodes.where(
	        work_id: obj.id,
	      ).order(index: :asc).first
			end


			prev_text_node = obj.text_nodes.where(
        "(
					index >= :current_text_node_index - :offset
	      and
					index < :current_text_node_index
        )",
				current_text_node_index: current_text_node.index,
				offset: args[:offset],
			).order(index: :asc).first

			if prev_text_node
				prev_text_node.location
			else
				[]
			end
		end
	end
end
