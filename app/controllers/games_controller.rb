class GamesController < ApplicationController
  before_action :authenticate_user! 
  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.create(user: current_user)
    respond_to do |format|
      format.js { render :create, status: 201 }
    end
  end

  def index

  end
end
