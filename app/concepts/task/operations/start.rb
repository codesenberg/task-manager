class Task::Start < Trailblazer::Operation
  include Policy
  policy Task::Policy, :start?

  def process(*)
    @model.start && @model.save
  end

  def model!(params)
    @model = Task.find(params[:id])
  end
end