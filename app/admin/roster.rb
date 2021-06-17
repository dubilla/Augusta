ActiveAdmin.register Roster do
  permit_params :team_id, :league_tournament_id

  form do |f|
    panel "Roster" do
      f.input :team
      f.input :league_tournament
    end
    actions
  end
end
