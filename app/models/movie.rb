class Movie < ActiveRecord::Base
  RATINGS = %w(G PG PG-13 R NC-17)
 
  validates :title, presence: true
  validates :rating, presence: true, inclusion: RATINGS


  scope :with_ratings, ->(ratings) { where('rating in (?)', ratings) unless ratings.blank? }
end
