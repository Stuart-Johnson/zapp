class Species < ApplicationRecord
  has_many :animals

  DIET_TYPE_OPTIONS = ["Carnivore", "Herbivore", "Omnivore"]

  validates :name, presence: true, uniqueness: true
  validates :color, presence: true, uniqueness: true
  validates :diet_type, presence: true, :inclusion => { :in => DIET_TYPE_OPTIONS }

  # Scope for herbivore species
  scope :herbivores, -> { where(diet_type: "Herbivore") }

  # Scope for carnivore species
  scope :carnivores, -> { where(diet_type: "Carnivore") }

  # Scope for omnivore species
  scope :omnivores, -> { where(diet_type: "Omnivore") }
end