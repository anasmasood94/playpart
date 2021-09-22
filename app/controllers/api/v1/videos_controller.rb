class Api::V1::VideosController < Api::V1::ApiController
    
    
    def create
        video = current_user.videos.new(create_params)
        if video.save
            render json: { id: video.id }.to_json, status: 200
        else
            render json: video.errors, status: 403
        end
    end

    def destroy
        video = current_user.videos.find_by_id(params[:id])
        if video.present?
          video.destroy
          render json: { success: true, msg: 'video Deleted Successfully.' }, status: 200
        else
          render json: { success: false, message: "Can't find video" }, status: 422
        end
    end

    def get_video_list

        video = current_user.videos
        if video.present?
            render json: video.order(updated_at: :desc), each_serializer: ::VideoSerializer::Base, adapter: :json
        else
            render json: { success: false, message: "Can't find video" }, status: 422
        end
    end   

    private
    def create_params
        params.permit(:video, :name)
    end
  
end