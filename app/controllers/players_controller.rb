class PlayersController < ApplicationController

  def index
    @players = Player.order(:last_name).all
    render json: @players
  end
end
