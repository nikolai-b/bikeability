class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :template_name
      t.string :body

      t.timestamps
    end
    add_index :email_templates, :template_name, unique: true
  end
end
