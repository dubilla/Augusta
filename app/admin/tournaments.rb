ActiveAdmin.register Tournament do
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

  permit_params :name, :start_date, :external_id, :completed

  form do |f|
    panel 'Tournament' do
      input :name
      input :start_date
      input :external_id
      input :completed
    end
    actions
  end
end
