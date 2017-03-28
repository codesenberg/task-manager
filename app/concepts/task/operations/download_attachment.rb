class Task
  # DownloadAttachment contains business logic for
  # downloading task's attachments
  class DownloadAttachment < Trailblazer::Operation
    include Trailblazer::Operation::Policy
    policy Task::Policy, :download_attachment?

    def process(*); end

    def model!(params)
      @attachment = Attachment.find(params[:id])
      @model = @attachment.task
    end

    attr_reader :attachment
  end
end
