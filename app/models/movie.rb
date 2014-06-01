class Movie < ActiveRecord::Base
  RATINGS = %w(G PG PG-13 R)
 
  validates :title, presence: true
  validates :rating, presence: true

  scope :with_ratings, ->(ratings) { where('rating in (?)', ratings) unless ratings.blank? }
end
