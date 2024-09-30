json.extract! food, :id, :name, :supplier, :storage_location, :treat, :created_at, :updated_at
json.url food_url(food, format: :json)
