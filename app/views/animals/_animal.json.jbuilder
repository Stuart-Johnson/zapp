json.extract! animal, :id, :name, :species, :birth_date, :active, :created_at, :updated_at
json.url animal_url(animal, format: :json)
