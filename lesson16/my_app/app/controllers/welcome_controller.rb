class WelcomeController < ApplicationController
  def index
    @posts = Post.all
    if params.has_key?(:id)
      @category_filter = @categories.find(params[:id])
    else
      @category_filter = nil
    end
  end
end
