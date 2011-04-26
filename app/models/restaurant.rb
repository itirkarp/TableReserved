class Restaurant < ActiveRecord::Base

  def save_with_images params
    self.save(params)
  end
end
