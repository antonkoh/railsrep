class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_menu_items
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  rescue_from ActionController::InvalidAuthenticityToken do |e|
    redirect_to :back, alert: 'User state changed. Please try again'
  end





  protected

  def check_user_access_to(resource)
    unless resource.available_for_edit_to?(current_user)
      redirect_to root_path, notice: 'You are unauthorized to perform this action.'
    end
  end


  def load_menu_items
    @categories = Category.all
  end

  def check_admin_rights
    unless is_current_user_admin?
      redirect_to root_path, alert: 'You don\'t have rights to perform this action.'
    end
  end

  def is_current_user_admin?
    user_signed_in? && current_user.is_admin?
  end

end
