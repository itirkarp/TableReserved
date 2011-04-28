class RemoveOfferFromRestaurant < ActiveRecord::Migration
  def self.up
    remove_column :restaurants, :offer
  end

  def self.down
    add_column :restaurants, :offer, :string
  end
end
