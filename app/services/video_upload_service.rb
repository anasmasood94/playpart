class VideoUploadService
  def self.upload file
    new.upload_file file
  end

  def upload_file file
    object = get_s3_object(extention(file))

    object.upload_file(file.path, acl: "public-read", content_type: file.content_type)
    object.public_url
  end

  private
  def extention file
    name_list = file.original_filename.split('.')
    if name_list.length > 1
      name_list.last
    else
      'mp4'
    end
  end

  def get_object_key extention
    "#{SecureRandom.hex(10)}-#{Date.today.to_s}.#{extention}"
  end

  def get_s3_object extention
    Aws::S3::Resource.new(
      access_key_id: ENV['AWS_ACCESS_ID'],
      secret_access_key: ENV['AWS_ACCESS_KEY'],
    region: ENV['AWS_REGION']).bucket(ENV['AWS_BUCKET']
                                      ).object(get_object_key(extention))
  end
end
