class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true).includes(:genres, :user)
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params_with_user)
    respond_to do |format|
      if @movie.save
        format.html { redirect_to movies_path, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params_with_user
    movie_params.merge(user_id: current_user.id)
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :user_id, genre_ids: [])
  end
end
