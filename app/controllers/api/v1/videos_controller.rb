class Api::V1::VideosController < Api::V1::ApiController

  def create
    video = current_user.videos.new(create_params)
    if video.save
      video_duration video
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
    videos = Video.with_list_order
    .paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)

    if videos.present?
      render json: videos, each_serializer: ::VideoSerializer::Base, adapter: :json, user_id: current_user.id
    else
      render json: { success: false, message: "Can't find video" }, status: 422
    end
  end

  private
  def create_params
    params.permit(:video, :name, :description)
  end

  def video_duration video
    duration = ActiveStorage::Analyzer::VideoAnalyzer.new(video.video.blob).metadata[:duration]
    if duration > 15
      video.destroy
      render json: { success: false, message: "Can't upload video of duration greater than 15 sec" }, status: 422
    else
      render json: { success: true, id: video.id }.to_json, status: 200
    end
  end
end
