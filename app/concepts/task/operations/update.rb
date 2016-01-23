class Task::Update < Trailblazer::Operation
  include Model
  model Task, :update

  include Policy
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