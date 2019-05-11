class LeaguesController < ApplicationController

  def index
    @leagues = League.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @league = League.includes(:tournaments, teams: :user).find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
