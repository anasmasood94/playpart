class Api::V1::AuthController < Api::V1::ApiController
  skip_before_action :authenticate_token, only: [:login, :sign_up]
  before_action :load_user_by_email, only: :login

  def login
    if @user.present? and @user.valid_password? params[:password]
      generate_token_and_reponse

    else
      render_error("Invalid email or password")
    end
  end

  def sign_up
    @user = User.create!(sign_up_params)
    generate_token_and_reponse
  end

  def log_out
    current_user.update api_token: nil
    render json: { sucess: true }, status: 200
  end

  private
    def generate_token_and_reponse
      token = @user.generate_access_token
      render json: @user, serializer: ::UserSerializer::Base, meta: { token: token }, adapter: :json
    end

    def load_user_by_email
      @user = User.find_by_email(params[:email])
    end

    def sign_up_params
      params.permit(:email, :user_name, :password, :password_confirmation)
        .merge({ first_name: user_first_name, last_name: user_last_name })
    end

    def user_first_name
      return "" unless params[:full_name]
       params[:full_name].split(' ')&.first || ""
    end

    def user_last_name
      return "" unless params[:full_name]
      params[:full_name].split(' ')[1..-1].join(' ') || ""
    end
end
