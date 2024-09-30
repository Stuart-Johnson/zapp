namespace :db do
  desc "Populate the foods table with 100 random food entries"
  task wipe_and_create_sample_data: :environment do
    require 'faker'

    puts "Truncating Tables..."
    ActiveRecord::Base.connection.truncate_tables(:foods, :animals, :servings)

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

    puts "Creating sample animals..."

    100.times do
      Animal.create!(
        name: Faker::Name.unique.first_name,
        species: Faker::Creature::Animal.name,
        birth_date: Faker::Date.birthday(min_age: 1, max_age: 20),
        active: Faker::Boolean.boolean
      )
    end

    puts "100 random animals created!"


    # puts "Creating sample servings..."

    # Animal.find_each do |animal|
    #   potential_foods = Food.all.to_a
    #   3.times do
    #     food = potential_foods.sample
    #     Serving.create!(
    #       animal: animal,
    #       food: food,
    #       serving_size: Faker::Food.measurement,
    #       meal: "Breakfast"
    #     )
    #     potential_foods.delete(food)
    #   end
    #   3.times do
    #     food = potential_foods.sample
    #     Serving.create!(
    #       animal: animal,
    #       food: food,
    #       serving_size: Faker::Food.measurement,
    #       meal: "Dinner"
    #     )
    #     potential_foods.delete(food)
    #   end
    # end

    # puts "Sample servings created!"
  end
end
