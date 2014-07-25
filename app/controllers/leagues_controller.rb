class LeaguesController < ApplicationController

  def index
    @leagues = League.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @league = League.includes(:teams).find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
