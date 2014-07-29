# Script to update all winners across LeagueTournaments
# TODO does not deal with ties
LeagueTournament.all.each{|lt| lt.rosters.sort_by{ |r| r.score }.first.update_attribute(:winner, true)}