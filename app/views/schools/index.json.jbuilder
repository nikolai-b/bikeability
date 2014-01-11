json.array!(@schools) do |school|
  json.extract! school, :id, :school_name, :address_line_1, :address_line_2, :city, :postcode, :telephone_number, :teacher_name, :email
  json.url school_url(school, format: :json)
end
