ActiveAdmin.register Roster do
  permit_params :team_id, :league_tournament_id, :winner, roster_players_attributes: [:id, :player_id]

  form do |f|
    panel "Roster" do
      f.input :team
      f.input :league_tournament
      f.input :winner
    end
    panel "Roster Players" do
      f.has_many :roster_players,
        heading: 'Players',
        allow_destroy: true,
        new_record: true do |rp|
          rp.input :player
        end
    end
    actions
  end
end
