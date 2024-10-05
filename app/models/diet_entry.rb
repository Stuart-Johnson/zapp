class DietEntry < ApplicationRecord
  belongs_to :animal
  belongs_to :food

  validates :animal_id, presence: true
  validates :food_id, presence: true

  # Validate that the structure of meals is correct
  validate :meals_structure_valid?

  # Ensure a food is unique for the same animal and meal
  # validates :food_id, uniqueness: { scope: [:animal_id, :meal], message: "has already been designated for this animal and meal, edit the existing serving instead." }

  DAYS_OF_WEEK = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  MEAL_OPTIONS = ['Breakfast', 'Dinner', 'Snack']

  private

  # Validation method for meals structure
  def meals_structure_valid?
    if meals.is_a?(Hash)
      meals.each do |day, meals_for_day|
        unless DAYS_OF_WEEK.include?(day)
          errors.add(:meals, "contains an invalid day: #{day}")
        end

        meals_for_day.each do |meal, serving_size|
          unless MEAL_OPTIONS.include?(meal)
            errors.add(:meals, "contains an invalid meal: #{meal} for #{day}")
          end
          unless serving_size.is_a?(String) && serving_size.present?
            errors.add(:meals, "must have a valid serving size for #{meal} on #{day}")
          end
        end
      end
    else
      errors.add(:meals, 'must be a valid hash')
    end
  end
end
