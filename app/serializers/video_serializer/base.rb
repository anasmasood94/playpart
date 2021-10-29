module VideoSerializer
  class Base < ActiveModel::Serializer
    attributes  :id, :name, :created_at, :updated_at, :result_video_url, :user_name
  
    def result_video_url
      if object.video.attached?
        object.video.service_url
      end
    end 
    def user_name
      current_user.user_name
    end
  end
end
  