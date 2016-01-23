class Task::Policy
  def initialize(user, task)
    @user, @task = user, task
  end

  def create?
    true
  end

  def show?
    is_task_owner?
  end

  def update?
    is_task_owner? && !@task.finished?
  end

  def destroy?
    is_task_owner? && !@task.finished?
  end

  def start?
    is_task_owner?
  end

  def finish?
    is_task_owner?
  end

  def add_attachment?
    is_task_owner? && !@task.finished?
  end

  def destroy_attachment?
    is_task_owner? && !@task.finished?
  end

  def download_attachment?
    is_task_owner?
  end

  private
  def is_task_owner?
    @task.user_id == @user.id
  end
end