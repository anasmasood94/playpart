class Api::V1::UsersController < Api::V1::ApiController
  def update
    if current_user.update(update_params)
      render json: { success: true }.to_json, status: 200
    else
      render json: { success: false, message: current_user.errors.full_messages.first}, status: 422
    end
  end

  private
  def update_params
    params.permit(:password, :password_confirmation).merge({ first_name: user_first_name, last_name: user_last_name })
  end
end
