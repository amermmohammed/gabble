class ExpandedUserInfos < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :age, :integer, null: false, default: 0
    add_column :users, :gender, :string, null: false, default: ""
    add_column :users, :birthday, :datetime, null: true, default: nil
    add_column :users, :bio, :string, null: false, default: ""
    add_column :users, :relationship, :string, null: false, default: ""
    add_column :users, :work, :string, null: false, default: ""
    add_column :users, :previous_jobs, :string, null: false, default: ""
    add_column :users, :education, :string, null: false, default: ""
    add_column :users, :previous_education, :string, null: false, default: ""
    add_column :users, :address, :string, null: false, default: ""
    add_column :users, :city, :string, null: false, default: ""
    add_column :users, :state, :string, null: false, default: ""
    add_column :users, :zip, :string, null: false, default: ""
    add_column :users, :country, :string, null: false, default: ""
    add_column :users, :phone, :string, null: false, default: ""
    add_column :users, :avatar, :string, null: false, default: ""
    add_column :users, :cover_image, :string, null: false, default: ""
    add_column :users, :status, :string, null: false, default: ""
    add_column :users, :last_login, :datetime, null: true, default: nil
    add_column :users, :last_logout, :datetime, null: true, default: nil
  end
end
