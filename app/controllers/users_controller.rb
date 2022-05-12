class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :session_now, only: [:new]
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render new
    end
  end

  def show
    if current_user.id == User.find_by(id: @user).id or current_user.admin_flag
      @tasks = Task.where(user_id: @user.id)
    else
      redirect_to tasks_path
    end
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit %i( name email password password_confirmation admin_flag )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def session_now
    redirect_to tasks_path if current_user
  end
end
