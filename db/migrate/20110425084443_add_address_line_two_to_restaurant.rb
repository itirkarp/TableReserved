class AddAddressLineTwoToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :address_line_2, :string
  end

  def self.down
    remove_column :restaurants, :address_line_2
  end
end
