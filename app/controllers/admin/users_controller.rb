class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :admin_check?

  def new
    @user = User.new
  end

  def index
     @users = User.includes(:tasks)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render new
    end
  end

  def update
    if @user.update(update_user_params)
      redirect_to admin_users_path
    else
      redirect_to edit_admin_user_path(@user.id)
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "削除しました"
    else
      redirect_to admin_users_path, notice: "削除できませんでした"
    end
  end

  private

  def admin_check?
    redirect_to tasks_path unless current_user.admin_flag
  end

  def user_params
    params.require(:user).permit %i( name email password password_confirmation admin_flag )
  end

  def update_user_params
    params.require(:user).permit %i( name email admin_flag )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
