class Task
  # DestroyAttachment contains business logic for removing attachments
  # from existing task
  class DestroyAttachment < Trailblazer::Operation
    include Trailblazer::Operation::Policy
    policy Task::Policy, :destroy_attachment?

    def process(*)
      @attachment.destroy
    end

    def model!(params)
      @attachment = Attachment.find(params[:id])
      @model = @attachment.task
    end
  end
end
