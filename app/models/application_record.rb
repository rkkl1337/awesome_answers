class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # ApplicationRecord is the superclass of all our models.
  # Write behaviour here that you want share amongst your models.
  # Any method you write in this class will be accessible by
  # all your model classes.

def edited?
    created_at != updated_at
  end
end
