class Task::Create < Trailblazer::Operation
  include Model
  model Task, :create

  include Policy
  policy Task::Policy, :create?

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

    property :user_id, validates: {presence: true}

    collection :attachments, populate_if_empty: :populate_attachments! do
      property :file,
               validates: {
                 file_size: { less_than_or_equal_to: Attachment::MAX_FILE_SIZE },
                 file_content_type: {
                   allow: Attachment::ALLOWED_MIME_TYPES
                 }
               }
    end

    def populate_attachments!(fragment:, **)
      Attachment.new(file: fragment["file"])
    end
  end

  def process(params)
    validate(params) do
      contract.save
    end
  end
end