class MoviesController < ApplicationController

  def index
#    @movies = Movie.find(:all).sort { |a,b| a.released_on <=> b.released_on }
#     @movies = Movie.all
    @movies_ratings = Movie.ratings.sort
    session[:sort_by] ||= 'title'
    session[:ratings] ||= @movies_ratings
    session[:sort_by] = (params[:sort].blank? ? session[:sort_by] : params[:sort])
    
    session[:ratings] = (params[:ratings].blank? ? session[:ratings] : params[:ratings].keys)
    @movies = Movie.where(:rating => session[:ratings]).order("#{session[:sort_by]} ASC")
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
