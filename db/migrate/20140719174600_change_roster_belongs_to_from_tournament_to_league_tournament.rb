class ChangeRosterBelongsToFromTournamentToLeagueTournament < ActiveRecord::Migration
  def change
    remove_reference :rosters, :tournament
    add_reference :rosters, :league_tournament
  end
end
