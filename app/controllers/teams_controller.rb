class TeamsController < ApplicationController

  def index
    @teams = Team.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
