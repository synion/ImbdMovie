require 'spec_helper'
require 'rails_helper'

describe MovieDecorator do
  describe '#genre_names' do
    it 'returns all included names' do
      user = create(:user)
      genre_first = create(:genre, title: 'action')
      genre_second = create(:genre, title: 'animation')

      movie = create(:movie, genres: [genre_first, genre_second])

      expect(movie.decorate.genre_names).to eq 'Action, Animation'
    end
  end
end
