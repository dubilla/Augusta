ActiveAdmin.register LeagueTournament do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :league_id, :tournament_id

  form do |f|
    panel 'League Tournament' do
      f.input :league
      f.input :tournament
    end
    actions
  end
end
