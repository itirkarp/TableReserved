class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name
      t.string :photo
      t.string :logo
      t.string :offer
      t.string :location
      t.string :cuisine
      t.date :offer_end_date
      t.string :offer_valid_days
      t.string :offer_valid_times
      t.string :address
      t.string :phone
    end
  end

  def self.down
    drop_table :restaurants
  end
end
