class Task
  # Create contains business logic for creating new tasks
  class Create < Trailblazer::Operation
    include Model
    model Task, :create

    include Trailblazer::Operation::Policy
    policy Task::Policy, :create?

    contract do
      property :name,
               validates: {
                 presence: true,
                 length: { maximum: Task::MAX_NAME_LENGTH }
               }

      property :description,
               validates: {
                 presence: true,
                 length: { maximum: Task::MAX_DESCRIPTION_LENGTH }
               }

      property :user_id, validates: { presence: true }

      collection :attachments, populate_if_empty: :populate_attachments! do
        property :file,
                 validates: {
                   file_size: {
                     less_than_or_equal_to: Attachment::MAX_FILE_SIZE
                   },
                   file_content_type: {
                     allow: Attachment::ALLOWED_MIME_TYPES
                   }
                 }
      end

      def populate_attachments!(fragment:, **)
        Attachment.new(file: fragment['file'])
      end
    end

    def process(params)
      validate(params) do
        contract.save
      end
    end
  end
end
