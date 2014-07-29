# Script to update all winners across LeagueTournaments
# TODO does not deal with ties
LeagueTournament.all.each{|lt| lt.rosters.collect(&:roster_players).flatten.sort_by{|p|p.score}.first.update_attribute(:winner, true)}