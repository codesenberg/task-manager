class Task::Destroy < Trailblazer::Operation
  include Policy
  policy Task::Policy, :destroy?

  def process(*)
    @model.destroy
  end

  def model!(params)
    @model = Task.find(params[:id])
  end
end