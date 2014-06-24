class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @all_ratings = Movie::RATINGS
    @sort = params[:sort]
    @ratings = params[:ratings].try(:keys) || @all_ratings
    @movies = Movie.for_user(current_user).order(sort_column + " " + sort_direction).with_ratings(@ratings)
    session[:previous_settings] = {}
    session[:previous_settings].merge!(sort: @sort) unless @sort.blank?
    session[:previous_settings].merge!(ratings: params[:ratings]) unless @ratings.blank?
  end

  def show
    @movie = find_movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_url
    else
      render 'new'
    end
  end

  def edit
    @movie = find_movie
    return not_found unless @movie.user == current_user
  end

  def update
    @movie = find_movie
    return not_found unless @movie.user == current_user
    if @movie.update_attributes(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def destroy
    @movie = find_movie
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_url
  end

  private

  def not_found
    render :file => "#{Rails.root}/public/404", formats: [:html], status: :not_found, layout: false
  end

  def find_movie
    Movie.for_user(current_user).find(params[:id])
  end

  def movie_params
    params[:movie].permit(:title, :rating, :release_date, :description, :poster, :published)
  end

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end

  def sort_direction
   %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
