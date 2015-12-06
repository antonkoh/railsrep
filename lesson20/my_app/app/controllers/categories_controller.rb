class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # def index
  #   @categories = Category.all
  # end
  #
  # def new
  #   @category = Category.new
  # end
  #
  # def create
  #   @category = Category.new(category_params)
  #
  #   if @category.save
  #     redirect_to categories_path
  #   else
  #     render :new
  #   end
  # end
  #
  # def update
  #   if @category.update(category_params)
  #     redirect_to categories_path
  #   else
  #     render :edit
  #   end
  #
  # end

  def show
    @posts = @category.posts.approved.all
    @header = @category.title
    render 'posts/post_list'
  end

  # def edit
  # end
  #
  # def destroy
  #   @category.destroy
  #   redirect_to categories_path
  #  end

  private
  # def category_params
  #   params.require(:category).permit(:title)
  # end

  def set_category
    @category = Category.find(params[:id])
  end
end