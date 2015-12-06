class PostsController < ApplicationController
  before_action :authenticate_user!, only:[:add_subscriber, :moderated, :drafts]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :return_to_draft, :publish, :add_subscriber]
  before_action :check_user_for_edit, only: [:edit, :update, :destroy, :return_to_draft, :publish]
  before_action :check_admin_rights, only: [:require_moderation]
  before_action :check_user_for_read, only: [:show]

  # GET /posts
  # GET /posts.json

 def index
    @posts = Post.approved.all
 end

  def draft
    @posts = Post.draft
    @header = controller_t('headers.drafts')
    render_user_posts
  end

  def moderated
    @posts = Post.moderated
    @header = controller_t('headers.moderated')
    render_user_posts
  end

  def approved
    @posts = Post.approved
    @header = controller_t('headers.published')
    render_user_posts
  end

  def require_moderation
    @posts = Post.moderated.all
    @header = controller_t('headers.require_moderation')
    render 'posts/post_list'
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
    puts @post.inspect
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(get_full_params)
    notice = case @post.status
               when "draft"
                 controller_t('notices.draft')
               when "moderated"
                 controller_t('notices.moderated')
               when "approved"
                 controller_t('notices.published')
             end
    @post.user = current_user if user_signed_in?
    if @post.save
      redirect_to @post, notice: notice
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
      old_status = @post.status
      if @post.update(get_full_params)
        notify_author if (@post.status != old_status && @post.status != "moderated")
        # notify only if the status has changed
        # notify only if the new status is not "moderated" (should not happen on status update but just in case)
        redirect_to @post, notice: controller_t('notices.updated')
      else
        render :edit
      end
  end

  def publish
    if is_current_user_admin?
      unless @post.approved?
        @post.approved!
        notify_author
      end
      redirect_to @post, notice: controller_t('notices.published')
    else
      @post.moderated! unless @post.moderated?
      redirect_to @post, notice: controller_t('notices.moderated')
    end
  end




  def return_to_draft
    if @post.user.present?
    # anonymous posts cannot be returned to draft
      unless @post.draft?
        @post.draft!
        notify_author
      end
      redirect_to @post, notice: controller_t('notices.returned')
    else
      redirect_to @post, notice: controller_t('notices.unreturnable')
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: controller_t('notices.deleted')
  end

  def add_subscriber
    if user_signed_in?
      @post.subscribers << current_user
    end
    redirect_to @post, notice: controller_t('notices.subscribed')
  end




  protected
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :is_draft, category_ids: [])
    end

    def additional_params
      params.permit(:is_draft)
    end


  def check_user_for_edit
    check_user_access_to(@post)
  end

  def check_user_for_read #only admins and authors can see draft posts
    check_user_access_to(@post) if @post.draft?
  end

  def render_user_posts
    @posts = @posts.created_by(current_user).all
    render 'posts/post_list'
  end

  def get_full_params
    get_post_params = post_params
    get_post_params[:status] = (additional_params[:is_draft]? "draft" : (is_current_user_admin? ? "approved" : "moderated"))
    get_post_params
  end

  def notify_author
    if is_current_user_admin? && @post.user.present? && @post.user != current_user
      #notify only if an admin performs the action
      #do not notify anonymous posts
      #do not notify admins about changes they make in their own posts
      UserMailer.post_notification(@post).deliver_now
    end
  end
end
