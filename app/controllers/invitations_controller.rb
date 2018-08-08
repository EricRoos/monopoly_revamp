class InvitationsController < ApplicationController
  before_action :find_invitation, only: [:accept, :decline]
  before_action :authorize_invite, only: [:accept, :decline]

  def index
    @invitations = current_user.invitations.includes(:sender)
  end

  def accept
    @invitation.accept
    redirect_to @invitation.game
  end

  def decline 
    @invitation.decline
    redirect_to games_path, notice: 'Declined an invitation.'
  end

  def create
    @invitation = game.invitations.build(invitation_params)
    authorize @invitation
    if @invitation.save
      flash[:notice] = "Invitation Sent!"
      status = :created if @invitation.persisted?
    else
      status = :bad_request
    end
    render 'create', status: status
  end

  protected

  def invitation_params
    params.require(:invitation).permit(:user_id) 
  end

  def game
    @game ||= Game.find(params[:game_id])
  end

  def find_invitation
    @invitation = Invitation.find(params[:id])
  end

  def authorize_invite
    head :unauthorized and return unless @invitation.user == current_user
  end
end
