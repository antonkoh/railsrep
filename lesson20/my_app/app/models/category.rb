class Category < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true
  has_many :category_posts
  has_many :posts, through: :category_posts
end