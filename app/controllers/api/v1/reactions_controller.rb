class Api::V1::ReactionsController < Api::V1::ApiController
  before_action :load_reaction, except: :create

  def create
    reaction = current_user.reactions.new(reaction_params)
    if reaction.save
      render json: { success: true, id: reaction.id, message: 'Reaction created Successfully.' }.to_json, status: 200
    else
      render_error reaction.errors.full_messages.first
    end
  end

  def update
    if @reaction && @reaction.update(reaction_params)
      respond_success 'Reaction updated Successfully.'
    else
      render_error @reaction.errors.full_messages.first
    end
  end

  def destroy
    if @reaction && @reaction.destroy
      respond_success 'Reaction deleted Successfully.'
    else
      render_error @reaction.errors.full_messages.first
    end
  end

  private
  def load_reaction
    @reaction = current_user.reactions.find_by_id(params[:id])
  end

  def reaction_params
    params.permit(:video_id, :reaction)
  end
end
