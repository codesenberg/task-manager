class AttachmentUploader < CarrierWave::Uploader::Base
  def store_dir
    Rails.root.join("private/#{Rails.env}/uploads/#{model.class.name.underscore}/#{mounted_as}/#{model.id}")
  end

  def cache_dir
    Rails.root.join("private/tmp/uploads")
  end
end