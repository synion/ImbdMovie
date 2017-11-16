class MovieDecorator < ApplicationDecorator
  def genre_names
    genres.pluck(:title).map(&:capitalize).join(', ')
  end
end
