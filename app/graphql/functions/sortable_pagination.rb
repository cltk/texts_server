class Functions::SortablePagination < Functions::Pagination
  argument :sort_field, types.String, default_value: "index"
  argument :sort_direction, types.String, default_value: 'ASC'

  def call(obj, args, ctx)
    super.order("#{args[:sort_field]} #{args[:sort_direction]}")
  end
end
