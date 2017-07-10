class Task < ApplicationRecord
  has_many :users
  belongs_to :project
  validates :title, :description, :status, presence: true
end