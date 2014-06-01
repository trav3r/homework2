module MoviesHelper
  def movies_th_class(order_param)
    request.fullpath.include?(order_param) ? 'highlight' : ''
  end
end