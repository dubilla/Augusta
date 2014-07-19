class LeaguesController < ApplicationController

  def show
    @league = League.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
