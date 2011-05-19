class RemoveLocationFromRestaurants < ActiveRecord::Migration
  def self.up
    remove_column :restaurants, :location
  end

  def self.down
    add_column :restaurants, :location, :string
  end
end
