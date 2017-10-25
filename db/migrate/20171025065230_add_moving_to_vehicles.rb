class AddMovingToVehicles < ActiveRecord::Migration[5.1]
  def change
    add_column :vehicles, :moving, :boolean
  end
end
