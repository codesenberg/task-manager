class Task
  # Update contains business logic for updating tasks
  class Update < Trailblazer::Operation
    include Model
    model Task, :update

    include Trailblazer::Operation::Policy
    policy Task::Policy, :update?

    contract do
      property :name,
               validates: {
                 presence: true,
                 length: { maximum: Task::MAX_NAME_LENGTH }
               }

      property :description,
               validates: {
                 presence: true,
                 length: { maximum: Task::MAX_DESCRIPTION_LENGTH }
               }
    end

    def process(params)
      validate(params[:task]) do
        contract.save
      end
    end
  end
end
