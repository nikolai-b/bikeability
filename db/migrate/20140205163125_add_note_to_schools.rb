class AddNoteToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :note, :text
  end
end
