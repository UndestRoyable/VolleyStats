ActiveAdmin.register Team do
  permit_params :coach_id, :name

  index do
    selectable_column
    id_column
    column :coach_id
    column :name
    column :number_players
    column :created_at
    column :last_modified
    actions
  end

  filter :name
  filter :coach
  filter :created_at

  form do |f|
    f.inputs "Team Details" do
      f.input :name
      f.input :coach
      f.input :number_players
    end
    f.actions
  end
end
