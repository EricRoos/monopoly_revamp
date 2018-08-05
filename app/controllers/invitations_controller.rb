class InvitationsController < ApplicationController
  def create
    head :unauthorized and return unless game.user == current_user
    @invitation = game.invitations.build(invitation_params)
    @invitation.save
    flash[:notice] = "Invitation Sent!"
    status = 201 if @invitation.persisted?
    status = 400 if @invitation.errors.present? && !@invitation.persisted?
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
