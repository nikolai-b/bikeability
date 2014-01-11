json.array!(@bookings) do |booking|
  json.extract! booking, :id, :school_id, :start_time, :num_children, :required_bikes, :required_helmets
  json.url booking_url(booking, format: :json)
end
