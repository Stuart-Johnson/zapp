namespace :db do
  desc "Populate the foods table with 100 random food entries"
  task wipe_and_create_sample_data: :environment do
    require 'faker'

    puts "Truncating Tables..."
    ActiveRecord::Base.connection.truncate_tables(:foods, :animals, :diet_entries, :species)

    puts "Creating sample foods..."

    100.times do
      Food.create!(
        name: Faker::Food.unique.ingredient,
        supplier: Faker::Company.name,
        storage_location: Faker::Address.mail_box,
        treat: Faker::Boolean.boolean
      )
    end

    puts "100 random foods created!"

    puts "Creating sample species..."

    20.times do
      Species.create!(
        name: Faker::Creature::Animal.unique.name,
        color: ['#ffffff', '#ffffff', '#ffffff', Faker::Color.unique.hex_color].sample,
        diet_type: Species::DIET_TYPE_OPTIONS.sample
      )
    end

    puts "20 random species created!"

    puts "Creating sample animals..."

    100.times do
      Animal.create!(
        name: Faker::Name.unique.first_name,
        species: Species.all.sample,
        birth_date: Faker::Date.birthday(min_age: 1, max_age: 20),
        active: Faker::Boolean.boolean
      )
    end

    puts "100 random animals created!"

    puts "Creating sample diets..."

    Animal.find_each do |animal|
      potential_foods = Food.all.to_a

      # Iterate over 3 different foods for sample purposes
      3.times do
        food = potential_foods.sample

        # Define the serving sizes for breakfast and dinner
        breakfast_size = Faker::Food.measurement
        dinner_size = Faker::Food.measurement

        # Randomly select 4 days for this food
        selected_days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].sample(4)

        # Build the meals structure for the selected days
        meals_for_animal = {}
        selected_days.each do |day|
          meals_for_animal[day] = {
            "Breakfast" => breakfast_size,
            "Dinner" => dinner_size
          }
        end

        # Create a DietEntry for this food and the associated meals on the selected days
        DietEntry.create!(
          animal: animal,
          food: food,
          meals: meals_for_animal
        )

        potential_foods.delete(food)
      end
    end


    puts "Sample diets created!"
  end
end
