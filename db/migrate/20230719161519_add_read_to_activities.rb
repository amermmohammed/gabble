class AddReadToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :read, :boolean, default: false
  end
end
