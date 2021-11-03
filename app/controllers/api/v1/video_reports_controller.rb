class Api::V1::VideoReportsController < Api::V1::ApiController

  def create
    video_reports = current_user.video_reports.find_or_initialize_by(create_params)
    if video_reports.save
      render json: { success: true  }.to_json, status: 200
    else
      render json: video_reports.errors, status: 403
    end
  end

  private
  def create_params
    params.permit(:video_id, :reason)
  end
end
