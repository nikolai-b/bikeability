class AddUuidToSchoolTeachers < ActiveRecord::Migration
  def change
    add_column :school_teachers, :uuid, :string
  end
end
