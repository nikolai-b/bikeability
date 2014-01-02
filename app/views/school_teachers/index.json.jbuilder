json.array!(@school_teachers) do |school_teacher|
  json.extract! school_teacher, :id, :name, :school, :address_line_1, :address_line_2, :city, :postcode, :telephone_number, :email
  json.url school_teacher_url(school_teacher, format: :json)
end
