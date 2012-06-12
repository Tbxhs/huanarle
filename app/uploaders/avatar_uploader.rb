# encoding: utf-8
class AvatarUploader < BaseUploader
  storage :upyun

  def default_url
    "avatar/#{version_name}.gif"
  end

  def store_dir
    'uploaded/avatar'
  end  

  version :normal do
    process :resize_to_fill => [50, 50]
  end

  version :small do
    process :resize_to_fill => [30, 30]
  end

  version :large do
    process :resize_to_fill => [200, 200]
  end

  version :big do
    process :resize_to_fill => [300, 300]
  end

end