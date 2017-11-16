class CreateGenresMoviesJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :genres_movies, id: false do |t|
      t.integer :genre_id
      t.integer :movie_id
    end

    add_index :genres_movies, :genre_id
    add_index :genres_movies, :movie_id
  end
end
