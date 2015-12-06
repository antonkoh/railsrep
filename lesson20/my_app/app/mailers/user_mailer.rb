class UserMailer < ApplicationMailer

  def comment_notification(post,comment,receiver,reason)
    if receiver.is_active?
      @reason = reason
      @post = post
      @comment = comment
      @receiver = receiver.email
      @comment_author = (comment.user.present? ? comment.user.email : nil)
      mail(to:@receiver,subject: "New comment for #{@post.title}")
    end
  end

  def post_notification(post)
    @receiver = post.user
    if @receiver.present? && @receiver.is_active?
      @reason = (post.approved? ? :approved : :declined)
      @post = post
      @receiver = @receiver.email
      mail(to:@receiver,subject: "Post #{@post.title} has been #{@reason.to_s}")
    end
  end
end
