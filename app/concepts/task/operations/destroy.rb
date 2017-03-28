class Task
  # Destroy contains business logic for deleting tasks
  class Destroy < Trailblazer::Operation
    include Trailblazer::Operation::Policy
    policy Task::Policy, :destroy?

    def process(*)
      @model.destroy
    end

    def model!(params)
      @model = Task.find(params[:id])
    end
  end
end
