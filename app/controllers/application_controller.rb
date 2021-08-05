class ApplicationController < ActionController::API
  def health_check
    head :ok
  end
end
