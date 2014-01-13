class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.string :telephone_number
      t.string :post_code

      t.timestamps
    end
  end
end
