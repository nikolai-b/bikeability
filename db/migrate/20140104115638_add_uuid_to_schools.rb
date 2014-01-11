class AddUuidToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :uuid, :string
  end
end
