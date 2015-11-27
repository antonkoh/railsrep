class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  has_many :comments, dependent: :destroy
  has_many :category_posts, dependent: :destroy
  has_many :categories, through: :category_posts
  has_many :tag_posts
  has_many :tags, through: :tag_posts
  belongs_to :user

  def categories_list
    str = ''
    categories.each_with_index do |c,i|
      str += c.title
      str += ', ' if i < categories.size - 1
    end
    return str
  end

  def available_for_edit_to?(user)
    user && (user.id == user_id || user.is_admin?)
  end
end
