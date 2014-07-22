ActiveAdmin.register Referee do

  permit_params :first_name, :last_name, :country_id

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :country
    column :created_at
    column :last_modified
    actions
  end

  filter :first_name
  filter :last_name
  filter :country
  filter :created_at

  form do |f|
    f.inputs "Referee Details" do
      f.input :first_name
      f.input :last_name
      f.input :country
    end
    f.actions
  end

end
