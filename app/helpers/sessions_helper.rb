module SessionsHelper

  def offer_validity restaurant
    "Till #{restaurant.offer_end_date}, on #{restaurant.offer_valid_days}, at times #{restaurant.offer_valid_times}"
  end
end
