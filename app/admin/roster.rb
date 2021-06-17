ActiveAdmin.register Roster do
  permit_params :team_id, :league_tournament_id

  form do |f|
    panel "Roster" do
      f.input :team_id
      f.input :league_tournament_id
    end
    actions
  end
end
