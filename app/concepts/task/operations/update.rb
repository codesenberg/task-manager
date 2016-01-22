class Task::Update < Trailblazer::Operation
  include Model
  model Task, :update

  include Policy
  policy Task::Policy, :update?

  contract do
    property :name,
             validates: {
                 presence: true,
                 length: { maximum: 100 }
             }

    property :description,
             validates: {
                 presence: true,
                 length: { maximum: 3000 }
             }
  end

  def process(params)
    validate(params[:task]) do
      contract.save
    end
  end
end