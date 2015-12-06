class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :post
  belongs_to :user
  validates :post_id, presence: true

  after_save :send_notification

  def available_for_edit_to?(user)
    user && (user.id == user_id || user.is_admin?)
  end

  protected
  def send_notification
    if post.user.present?
      UserMailer.comment_notification(post,self,post.user,:author).deliver_now
    end
    post.subscribers.each {|s| UserMailer.comment_notification(post,self,s,:subscriber).deliver_now}
  end
end
