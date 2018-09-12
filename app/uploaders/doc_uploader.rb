class DocUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(doc pdf docx)
  end

  def filename
    File.basename(path) if path.present?
  end
end
