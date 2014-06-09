require 'spec_helper'

describe Movie do
  context '.with_ratings' do
    it 'No movies - no results' do
      expect(Movie.with_ratings([]).to_a).to eq([])
    end

    it 'One movie with blank condition - one result' do
      movie = Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
      expect(Movie.with_ratings([]).to_a).to eq([movie])
    end

    it 'Two movie with not blank condition - one result' do
      movie = Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
      Movie.create(title: 'bbb', rating: 'RG', release_date: Date.today)
      expect(Movie.with_ratings(['R']).to_a).to eq([movie])
    end

    it 'Two movie with not blank condition - two results' do
      movie = Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
      movie2 = Movie.create(title: 'bbb', rating: 'PG', release_date: Date.today)
      expect(Movie.with_ratings(['R', 'PG']).to_a).to eq([movie, movie2])
    end

    it 'One movie with not blank condition - no result' do
      Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
      expect(Movie.with_ratings(['RG']).to_a).to eq([])
    end
  end
end
