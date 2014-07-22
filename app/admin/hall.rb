ActiveAdmin.register Hall do

  permit_params :name, :city_id

  index do
    selectable_column
    id_column
    column :name
    column :city
    column :created_at
    column :last_modified
    actions
  end

  filter :name
  filter :city
  filter :created_at

  form do |f|
    f.inputs "Hall Details" do
      f.input :name
      f.input :city
    end
    f.actions
  end

end
