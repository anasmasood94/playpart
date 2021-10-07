class Api::V1::ApiController < ActionController::API
  extend Responders::ControllerMethod
  before_action :authenticate_token
  respond_to :json

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  protected

  def respond_success msg="Action was successful"
    render json: { success: true, msg: msg }, status: 200
  end

  def authenticate_token
    render json: { error: "Invalid Token" }, status: 401 if authorization_token.nil? or current_user.nil?
  end

  def current_user temp=false
    @current_user ||= User.find_by(api_token: authorization_token)
  end

  def authorization_token
    request&.headers["Authorization"]&.split("Bearer ")&.last
  end

  def render_error message
    render json: { sucess: false, message: message }, status: 403
  end

  def user_first_name
    return "" unless params[:full_name]
    params[:full_name].split(' ')&.first || ""
  end

  def user_last_name
    return "" unless params[:full_name]
    params[:full_name].split(' ')[1..-1].join(' ') || ""
  end

  private
  def render_unprocessable_entity(e)
    render json: { sucess: false, message: e.record.errors.full_messages.first }, status: 422
  end
end
