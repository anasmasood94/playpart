module VideoSerializer
  class Base < ActiveModel::Serializer
    attributes  :id, :name, :created_at, :updated_at, :result_video_url, :description

    def result_video_url
      if object.video.attached?
        object.video.service_url
      end
    end
  end
end

