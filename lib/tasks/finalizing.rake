namespace :finalizing do
  desc "Finalize a tournament"
  task :tournament, [:t_id] => :environment do |t, args|
    t_id = args[:t_id]
    tournament = Tournament.find(t_id)
    roster_players = RosterPlayer.joins(roster: { league_tournament: :tournament }).where("tournaments.id = ?", tournament.id)
    roster_players.each do |rp|
      rp.update(final_score: rp.score)
    end
    tournament.update_attributes(completed: true)
  end
end
