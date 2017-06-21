class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings.map do |rating|
      rating.rating
    end
    
    need_redirect = false
    keep_ratings_temp = flash[:ratings]
    if keep_ratings_temp
      @keep_ratings = keep_ratings_temp
    elsif params[:ratings] and not params[:ratings].empty?
      @keep_ratings = params[:ratings].keys
      session[:ratings] = @keep_ratings
    else
      if session[:ratings]
        @keep_ratings = session[:ratings]
        need_redirect = true
      else
        @keep_ratings = @all_ratings
      end
    end
    
    order_temp = flash[:order]
    if order_temp
      @order_item = order_temp
    elsif params[:order]
      @order_item = params[:order]
      session[:order] = @order_item
    else
      if session[:order]
        @order_item = session[:order]
        need_redirect = true
      else
        @order_item = ''
      end
    end
    
    if need_redirect
      flash[:ratings] = @keep_ratings
      flash[:order] = @order_item
      flash.keep
      redirect_to movies_path({order_item: @order_item, keep_ratings: @keep_ratings})
    end
    
    @movies = Movie.where({:rating => @keep_ratings})
    @order_item = @order_item.to_sym
    case @order_item
    when :title then @movies = @movies.order :title
    when :release_date then @movies = @movies.order :release_date
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
