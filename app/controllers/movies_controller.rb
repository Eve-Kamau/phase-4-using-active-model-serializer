class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    movies = Movie.all
    render json: movies
  end

    def show
    #METHOD 1
    # movie = Movie.find(params[:id])
    # render json: movie.to_json(only: [:id, :title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director])

    #METHOD 2
    # movie = Movie.find(params[:id])
    # render json: movie.to_json(except: [:created_at, :updated_at])

    #METHOD 3 - Ideal AMS Serializer
    movie = Movie.find(params[:id])
    render json: movie
   end

   def summary
      movie = Movie.find(params[:id])
      render json: movie, serializer: MovieSummarySerializer
   end

   def summaries
     movies = Movie.all
     render json: movies, each_serializer: MovieSummarySerializer
   end

  private

  def render_not_found_response
    render json: { error: "Movie not found" }, status: :not_found
  end
end
