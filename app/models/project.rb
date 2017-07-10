class Project < ApplicationRecord

  has_many :tasks
  validates :name, :summary, :start_date, :end_date, presence: true

end
