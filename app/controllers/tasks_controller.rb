class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def new
    @task = Task.new
  end

  def index
    @tasks = Task.order(created_at: "DESC")
    @tasks = Task.order(deadline: :DESC) if params[:sort_expired].present?
    @tasks = Task.order_by_priority if params[:sort_priority].present?
    @tasks = @tasks.search(params[:title_search], params[:status_search]) if params[:title_search].present? or params[:status_search].present?
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "登録しました"
    else
      flash.now[:danger] = "保存に失敗しました"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, {label_ids: []} )
  end
end
