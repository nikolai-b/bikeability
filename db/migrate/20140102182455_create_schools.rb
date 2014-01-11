class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :school_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postcode
      t.string :telephone_number
      t.string :teacher_name
      t.string :email

      t.timestamps
    end
  end
end
