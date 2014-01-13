json.array!(@instructors) do |instructor|
  json.extract! instructor, :id, :name, :email, :telephone_number, :post_code
  json.url instructor_url(instructor, format: :json)
end
