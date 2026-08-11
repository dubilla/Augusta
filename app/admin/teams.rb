ActiveAdmin.register Team do
  permit_params :league_id, :user_id

  # See league_tournaments.rb — drop PaperTrail's auto-generated `versions` filter.
  remove_filter :versions

  form do |f|
    panel "Team" do
      f.input :league
      f.input :user
    end
    actions
  end
end
