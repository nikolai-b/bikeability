class AddNoteToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :note, :text
  end
end
