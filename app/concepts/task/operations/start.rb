class Task
  # Start contains business logic for starting work on existing tasks
  class Start < Trailblazer::Operation
    include Trailblazer::Operation::Policy
    policy Task::Policy, :start?

    def process(*)
      @model.start && @model.save
    end

    def model!(params)
      @model = Task.find(params[:id])
    end
  end
end
