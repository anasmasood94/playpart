require 'streamio-ffmpeg'
class Api::V1::VideosController < Api::V1::ApiController

  before_action :validate_video_duration, only: :create

  def create
    video = current_user.videos.new(create_params)
    if video.save
      render json: { success: true, id: video.id }.to_json, status: 200
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
    videos = Video.with_list_order(current_user.id)
    .paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)

    if videos.present?
      render json: videos, each_serializer: ::VideoSerializer::Base, adapter: :json, user_id: current_user.id
    else
      render json: { success: false, message: "Can't find video" }, status: 422
    end
  end

  private
  def create_params
    params.permit(:name, :description).merge(video_url: VideoUploadService.upload(params[:video]))
  end

  def validate_video_duration
    movie = FFMPEG::Movie.new(params[:video].path)

    if movie.duration > 15
      render json: { success: false, message: "Can't upload video of duration greater than 15 sec" }, status: 422
    end
  end
end
