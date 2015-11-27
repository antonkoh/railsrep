class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :post
  belongs_to :user
  validates :post_id, presence: true

  def available_for_edit_to?(user)
    user && (user.id == user_id || user.is_admin?)
  end
end
