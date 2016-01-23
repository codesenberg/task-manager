class AttachmentUploader < CarrierWave::Uploader::Base
  def store_dir
    Rails.root.join("private/uploads/#{model.class.name.underscore}/#{model.id}")
  end

  def cache_dir
    Rails.root.join("private/tmp/uploads")
  end
end