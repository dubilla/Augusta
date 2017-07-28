namespace :scoring do
  desc "Designate winners for rosters in a league tournament"
  task :league_tournament_rosters, [:lt_id] => :environment do |t, args|
    lt_id = args.lt_id
    league_tournament = LeagueTournament.find(lt_id)
    roster_winner = league_tournament.rosters.max_by{|r| r.map(&:roster_players).sum(:final_score) }
    roster_winner.update_attributes(winner: true)
  end
end
