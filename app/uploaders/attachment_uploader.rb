class AttachmentUploader < CarrierWave::Uploader::Base
  def store_dir
    Rails.root.join("public/uploads/#{model.class.name.underscore}/#{model.id}")
  end
end