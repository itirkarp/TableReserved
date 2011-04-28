class ChangeOfferInRestaurant < ActiveRecord::Migration
  def self.up
    change_column :restaurants, :offer, :integer
  end

  def self.down
    change_column :restaurants, :offer, :string
  end
end
