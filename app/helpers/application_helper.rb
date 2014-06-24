module ApplicationHelper
	def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, movies_path(sort: column, direction: direction), class: css_class
  end

  def highlingt_if_movie(movie)
    'my-movie' if current_user && movie.user_id == current_user.id
  end
end
