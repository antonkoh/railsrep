class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  # def index
  #   @comments = Comment.all
  # end

  # GET /comments/1
  # GET /comments/1.json
  # def show
  # end

  # GET /comments/new
  # def new
  #   @comment = Comment.new
  # end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user if user_signed_in?

   if @comment.save
      redirect_to @post, notice: controller_t('notices.created')
   else
      @post.reload
      render 'posts/show'
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: controller_t('notices.updated')
    else
       render :edit
    end
   end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    redirect_to @post, notice: controller_t('notices.destroyed')
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      @post = @comment.post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end


    def check_user
      check_user_access_to(@comment)
    end


end
