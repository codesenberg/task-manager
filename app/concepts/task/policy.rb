class Task
  # Policy contains authorization rules for tasks
  class Policy
    def initialize(user, task)
      @user = user
      @task = task
    end

    def create?
      true
    end

    def show?
      task_owner?
    end

    def update?
      task_owner? && !@task.finished?
    end

    def destroy?
      task_owner? && !@task.finished?
    end

    def start?
      task_owner?
    end

    def finish?
      task_owner?
    end

    def add_attachment?
      task_owner? && !@task.finished?
    end

    def destroy_attachment?
      task_owner? && !@task.finished?
    end

    def download_attachment?
      task_owner?
    end

    private

    def task_owner?
      @task.user_id == @user.id
    end
  end
end
