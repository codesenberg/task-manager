# AttachmentUploader configures how attachments stored on disk
class AttachmentUploader < CarrierWave::Uploader::Base
  def store_dir
    Rails.root.join('private', Rails.env, 'uploads',
                    model.class.name.underscore, mounted_as.to_s, model.id.to_s)
  end

  def cache_dir
    Rails.root.join('private', 'tmp', 'uploads')
  end
end
