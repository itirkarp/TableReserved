class AddWebsiteToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :website, :string
  end

  def self.down
    remove_column :restaurants, :website
  end
end
