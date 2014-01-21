class CreateSchoolEmailTemplates < ActiveRecord::Migration
  def change
    create_table :school_email_templates do |t|
      t.string :body

      t.timestamps
    end
  end
end
