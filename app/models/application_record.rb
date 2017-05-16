class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def wrap_json(name)
    { name => self}
  end
end
