class RemoveUuidFromSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :uuid, :string
  end
end
