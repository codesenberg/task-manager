class Task::DownloadAttachment < Trailblazer::Operation
  include Policy
  policy Task::Policy, :download_attachment?

  def process(*); end

  def model!(params)
    @attachment = Attachment.find(params[:id])
    @model = @attachment.task
  end

  def attachment
    @attachment
  end
end