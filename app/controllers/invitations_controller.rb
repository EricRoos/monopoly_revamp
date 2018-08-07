class InvitationsController < ApplicationController
  before_action :find_invitation, only: [:accept, :decline]
  before_action :authorize, only: [:accept, :decline]

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

  def find_invitation
    @invitation = Invitation.find(params[:id])
  end

  def authorize
    head :unauthorized and return unless @invitation.user == current_user
  end
end
