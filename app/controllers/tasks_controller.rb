class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
  end

  def show
    @task = Task.includes(:attachments).find(params[:id])
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
    form Task::Update, params: params_with_user
  end

  def update
    operation = run Task::Update, params: params_with_user do |op|
      return redirect_to task_url(op.model)
    end

    @form = operation.contract
    render :edit
  end

  def start
    run Task::Start, params: params_with_user do |op|
      redirect_to task_url(op.model)
    end
  end

  def finish
    run Task::Finish, params: params_with_user do |op|
      redirect_to task_url(op.model)
    end
  end

  def destroy
    run Task::Destroy, params: params_with_user do
      redirect_to tasks_url
    end
  end
end
