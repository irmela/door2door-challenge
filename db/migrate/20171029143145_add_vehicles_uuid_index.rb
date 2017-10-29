class AddVehiclesUuidIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :vehicles, :uuid
  end
end
