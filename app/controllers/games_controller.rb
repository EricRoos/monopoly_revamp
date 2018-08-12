# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :authenticate_user!
  def show
    @game = Game.find(params[:id])
    authorize(@game)
  end

  def create
    @game = Game.create(user: current_user)
    respond_to do |format|
      format.js { render :create, status: 201 }
    end
  end

  def start
    @game = Game.find(params[:id])
    @game.start_game!
    flash[:notice] = 'Game Started!'
    respond_to do |format|
      format.js { render :start, status: 200 }
    end
  end

  def index; end
end
