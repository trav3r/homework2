module MoviesHelper
  def movies_th_class(url)
    url == request.fullpath ? 'highlight' : ''
  end
end