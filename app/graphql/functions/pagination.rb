class Functions::Pagination < GraphQL::Function
  attr_reader :type

  description "Provide pagination boilerplate for common lists of records"

  argument :limit, types.Int, default_value: 20, prepare: -> (limit, ctx) { [limit, 50].min }
  argument :offset, types.Int, default_value: 0
  
  def initialize(children: :itself, type:)
    @children = children
    @type = type
  end

  def call(obj, args, ctx)
    obj.send(@children).limit(args[:limit]).offset(args[:offset])
  end
end
