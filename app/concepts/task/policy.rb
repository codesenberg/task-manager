class Task::Policy
  def initialize(user, task)
    @user, @task = user, task
  end

  def create?
    true
  end

  def show?
    @task.user_id == @user.id
  end

  def update?
    @task.user_id == @user.id
  end

  def destroy?
    @task.user_id == @user.id
  end

  def start?
    @task.user_id == @user.id
  end

  def finish?
    @task.user_id == @user.id
  end

  def add_attachment?
    @task.user_id == @user.id
  end

  def destroy_attachment?
    @task.user_id == @user.id
  end

  def download_attachment?
    @task.user_id == @user.id
  end
end