class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order(updated_at: :desc).page(params[:page])
  end

  def show
    @task = Task.includes(:attachments).find_by!(id: params[:id])
    fail Trailblazer::NotAuthorizedError unless Task::Policy.new(current_user, @task).show?
  end

  def new
    form Task::Create
  end

  def create
    task_params = params[:task].merge(user_id: current_user.id)
    task_params[:attachments] = task_params.fetch(:attachments, []).map {|file| {file: file}}
    operation = run Task::Create, params: task_params do |op|
      return redirect_to task_url(op.model)
    end

    @form = operation.contract
    render :new
  end

  def edit
    form Task::Update, params: params.merge(current_user: current_user)
  end

  def update
    operation = run Task::Update, params: params.merge(current_user: current_user) do |op|
      return redirect_to task_url(op.model)
    end

    @form = operation.contract
    render :edit
  end

  def start
    @task = Task.find(params[:id])
    fail Trailblazer::NotAuthorizedError unless Task::Policy.new(current_user, @task).start?
    @task.start and @task.save
    redirect_to task_url(@task)
  end

  def finish
    @task = Task.find(params[:id])
    fail Trailblazer::NotAuthorizedError unless Task::Policy.new(current_user, @task).finish?
    @task.finish and @task.save
    redirect_to task_url(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    fail Trailblazer::NotAuthorizedError unless Task::Policy.new(current_user, @task).destroy?
    @task.destroy

    redirect_to tasks_url
  end
end
