class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def new
    @task = Task.new
  end

  def index
    @task = Task.all
  end

  def create
    @task = Task.new(task_params)
    if @task.sava
      redirect_to tasks_path, notice: "登録しました"
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

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit %i( title content )
  end
end
