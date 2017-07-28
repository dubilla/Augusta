namespace :scoring do
  desc "Designate winners for rosters in a league tournament"
  task :league_tournament_rosters, [:lt_id] => :environment do |t, args|
    lt_id = args[:lt_id]
    league_tournament = LeagueTournament.find(lt_id)
    winning_score = league_tournament.rosters.min_by(&:final_score).final_score
    roster_winners = league_tournament.rosters.select{|r| r.final_score == winning_score }
    roster_winners.each{|r| r.update_attributes(winner: true) }
  end

end
