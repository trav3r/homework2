class Movie < ActiveRecord::Base
  RATINGS = %w(G PG PG-13 R NC-17)
  mount_uploader :poster, PosterUploader
 
  validates :title, presence: true
  validates :rating, presence: true, inclusion: RATINGS

  belongs_to :user
  before_update :unpablish_for_usual_users

  scope :for_user, ->(user) do
    if user && !user.admin?
      where "movies.published = 't' OR (movies.published = 'f' AND movies.user_id = ?)", user.id
    end
  end

  scope :with_ratings, ->(ratings) { where('rating in (?)', ratings) unless ratings.blank? }

  private

  def unpablish_for_usual_users
    self.published = false unless user.admin?
  end
end
