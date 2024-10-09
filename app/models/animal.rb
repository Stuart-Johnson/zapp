class Animal < ApplicationRecord
  has_many :diet_entries, dependent: :destroy
  has_many :foods, through: :diet_entries

  validates :name, presence: true, uniqueness: true
  validates :species, presence: true
  validates :birth_date, presence: true

  # Scope for active animals
  scope :active, -> { where(active: true) }

  # Scope for archived animals
  scope :archived, -> { where(active: false) }

  def name_with_species
    "#{name} - (#{species})"
  end
end
