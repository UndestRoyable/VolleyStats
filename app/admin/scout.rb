ActiveAdmin.register Scout do

  permit_params :first_name, :last_name, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :last_modified
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs "Scout Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
