module AdminHelper

  def add_or_remove_link restaurant
    restaurant.visible ? link_to('Remove', remove_from_exclusives_url(restaurant.id)) : link_to('Add', add_to_exclusives_url(restaurant.id))
  end
end
