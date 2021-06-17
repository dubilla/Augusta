ActiveAdmin.register Team do
  permit_params :league_id, :user_id

  form do |f|
    panel "Team" do
      f.input :league
      f.input :user
    end
    actions
  end
end
