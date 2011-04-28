class AddOfferToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :offer, :integer
  end

  def self.down
    remove_column :restaurants, :offer
  end
end
