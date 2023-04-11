json.extract! reservation, :id, :user_id, :flight_id, :count, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
