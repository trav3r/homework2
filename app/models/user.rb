class User < ActiveRecord::Base
  ROLES = %w(user admin)
  include Clearance::User

  has_many :movies
	validates :role, presence: true, inclusion: ROLES

  def admin?
    role == 'admin'
  end
end
