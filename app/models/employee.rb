class Employee < ApplicationRecord
  belongs_to :department
  belongs_to :manager, class_name: 'Employee', optional: true
  has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id'
  def as_json(options = {})
    {
      :id => self.id,
      :name => self.name,
      :manager => self.manager.blank? ? '' : self.manager.name,
      :department => self.department.name
     }
  end
end
