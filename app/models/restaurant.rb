class Restaurant < ActiveRecord::Base

  validates_presence_of self.column_names - ["id"]

end
