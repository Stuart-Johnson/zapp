class Food < ApplicationRecord
  has_many :diet_entries, dependent: :destroy
  has_many :animals, through: :diet_entires

  validates :name, presence: true, uniqueness: true
end
