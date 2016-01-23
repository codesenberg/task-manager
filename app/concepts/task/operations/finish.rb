class Task::Finish < Trailblazer::Operation
  include Policy
  policy Task::Policy, :finish?

  def process(*)
    @model.finish && @model.save
  end

  def model!(params)
    @model = Task.find(params[:id])
  end
end