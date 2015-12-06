class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  before_action :check_admin_rights

  def index
    @users = User.all
  end


  def destroy
    @user.is_active = false
    @user.save
    redirect_to admin_users_path
   end

  private

  def set_user
    @user = User.find(params[:id])
  end
end