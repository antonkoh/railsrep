class Admin::CategoriesController < CategoriesController
  before_action :set_category, only: [:edit, :destroy, :update]
  before_action :check_admin_rights

  def index
    @categories = Category.all
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end

  end

  def edit
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
   end

  private
  def category_params
    params.require(:category).permit(:title)
  end

  # def set_category
  #   @category = Category.find(params[:id])
  # end
end