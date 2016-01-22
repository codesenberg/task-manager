class TaskController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find_by!(params[:id])
  end

  def new
    # @form = CreateTaskForm.new(Task.new)
  end

  def create
    # @form = CreateTaskForm.new(Task.new)
    # if @form.validate(params[:task])
    #   @form.save
    #   redirect_to task_url(@form.model)
    # else
    #   render :new
    # end
  end

  def edit
    # @form = EditTaskForm.new(Task.find(params[:id]))
  end

  def update
    # @form = EditTaskForm.new(Task.find(params[:id]))
    # if @form.validate(params[:task])
    #   @form.save
    #   redirect_to task_url(@form.model)
    # else
    #   render :edit
    # end
  end

  def start
  end

  def finish
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to task_index_url
  end
end
