class Attachment < ActiveRecord::Base
  belongs_to :task

  mount_uploader :file, AttachmentUploader

  ALLOWED_MIME_TYPES = ['image/jpeg', 'image/png']
  MAX_FILE_SIZE = 50.kilobytes
end
