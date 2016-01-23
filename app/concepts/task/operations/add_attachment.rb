class Task::AddAttachment < Trailblazer::Operation
  include Policy
  policy Task::Policy, :add_attachment?

  contract do
    property :file,
             validates: {
               presence: true,
               file_size: { less_than_or_equal_to: Attachment::MAX_FILE_SIZE },
               file_content_type: {
                 allow: Attachment::ALLOWED_MIME_TYPES
               }
             }
    property :task_id, validates: {presence: true}
  end

  def process(params)
    validate(params, @model.attachments.new) do |f|
      f.save
    end
  end

  def model!(params)
    @model = Task.find(params[:task_id])
  end
end