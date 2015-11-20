class User < ActiveRecord::Base
  validates :login, uniqueness: true
  has_one :user_profile
  has_many :posts

end
