class Task
  # Finish contains business logic for finishing work on existing task
  class Finish < Trailblazer::Operation
    include Trailblazer::Operation::Policy
    policy Task::Policy, :finish?

    def process(*)
      @model.finish && @model.save
    end

    def model!(params)
      @model = Task.find(params[:id])
    end
  end
end
