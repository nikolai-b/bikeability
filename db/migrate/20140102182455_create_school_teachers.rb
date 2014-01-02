class CreateSchoolTeachers < ActiveRecord::Migration
  def change
    create_table :school_teachers do |t|
      t.string :name
      t.string :school
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postcode
      t.string :telephone_number
      t.string :email

      t.timestamps
    end
  end
end
