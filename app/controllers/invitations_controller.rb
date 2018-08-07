class InvitationsController < ApplicationController
  def index
    @invitations = current_user.invitations.includes(:sender)
  end

  def accept
    @invitation = Invitation.find(params[:id])
    head :unauthorized and return unless @invitation.user == current_user
    if @invitation.accept
      redirect_to @invitation.game and return
    else
      render @invitation.game, notice: 'Something went wrong...'
    end
  end

  def decline 
    @invitation = Invitation.find(params[:id])
    head :unauthorized and return unless @invitation.user == current_user
    if @invitation.decline
      redirect_to games_path, notice: 'Declined an invitation.' and return
    else
      render games_path, notice: 'Something went wrong...'
    end
  end

  def create
    head :unauthorized and return unless game.user == current_user
    @invitation = game.invitations.build(invitation_params)
    @invitation.save
    flash[:notice] = "Invitation Sent!"
    status = :created if @invitation.persisted?
    status = :bad_request if @invitation.errors.present? && !@invitation.persisted?
    render 'create', status: status
  end

  protected

  def invitation_params
    params.require(:invitation).permit(:user_id) 
  end

  def game
    @game ||= Game.find(params[:game_id])
  end
end
