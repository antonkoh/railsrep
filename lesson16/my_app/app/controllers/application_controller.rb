class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_menu_items, only: [:index, :show, :new, :edit]

  protected
  def load_menu_items
    @categories = Category.all
  end
end
