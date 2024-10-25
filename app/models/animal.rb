class Animal < ApplicationRecord
  has_many :diet_entries, dependent: :destroy
  has_many :foods, through: :diet_entries
  belongs_to :species, required: true

  validates :name, presence: true, uniqueness: true
  # validates :species, presence: true
  validates :birth_date, presence: true

  # Scope for active animals
  scope :active, -> { where(active: true) }

  # Scope for archived animals
  scope :archived, -> { where(active: false) }

  def name_with_species
    "#{name} - (#{species.name})"
  end

  def breakfast_for_day(day_name)
    diet_entries.today_breakfast.each_with_object({}) do |entry, result|
      result[entry.food.name] = entry.meals[day_name]['Breakfast']
    end
  end

  def snack_for_day(day_name)
    diet_entries.today_snack.each_with_object({}) do |entry, result|
      result[entry.food.name] = entry.meals[day_name]['Snack']
    end
  end

  def dinner_for_day(day_name)
    diet_entries.today_dinner.each_with_object({}) do |entry, result|
      result[entry.food.name] = entry.meals[day_name]['Dinner']
    end
  end
end
