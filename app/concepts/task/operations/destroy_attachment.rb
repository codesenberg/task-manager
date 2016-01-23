class Task::DestroyAttachment < Trailblazer::Operation
  include Policy
  policy Task::Policy, :destroy_attachment?

  def process(*)
    @attachment.destroy
  end

  def model!(params)
    @attachment = Attachment.find(params[:id])
    @model = @attachment.task
  end
end