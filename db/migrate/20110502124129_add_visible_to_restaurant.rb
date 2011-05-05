class AddVisibleToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :visible, :boolean, :default => true
  end

  def self.down
    remove_column :restaurants, :visible
  end
end
