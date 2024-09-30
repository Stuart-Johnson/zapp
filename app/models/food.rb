class Food < ApplicationRecord
  # has_many :diet_entires
  # has_many :animals, through: :diet_entires

  validates :name, presence: true, uniqueness: true
end
