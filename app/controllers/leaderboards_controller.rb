class LeaderboardsController < ApplicationController

  def index
    @tournament ||= HTTParty.get('http://api.espn.com/v1/sports/golf/pga/events/1329?apikey=dv58z289n3pf5yw4gxrpzrwq')

    @league_tournament = LeagueTournament.find(params[:league_tournament_id])
    league_tournament_players = @league_tournament.rosters.collect(&:players).flatten
    player_ids = league_tournament_players.collect(&:external_id)

    all_competitors = @tournament["sports"].first["leagues"].first["events"].first["competitions"].first["competitors"]
    @player_leaders = all_competitors.select{|g| player_ids.include? g["athlete"]["id"] }

    respond_to do |format|
      format.html
    end
  end

end
