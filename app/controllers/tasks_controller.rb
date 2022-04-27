class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def new
    @task = Task.new
  end

  def index
    if params[:sort_expired] == nil
      @task = Task.order(created_at: "DESC")
    else
      @task = Task.order(deadline: :DESC)
    end
  end

  def create
    @task = Task.new(task_params)
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
      render :new
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
    params.require(:task).permit %i( title content deadline )
  end
end
