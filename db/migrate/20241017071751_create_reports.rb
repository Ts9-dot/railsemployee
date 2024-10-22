class CreateReports < ActiveRecord::Migration[7.2]
  def change
    create_table :reports do |t|
      t.string :title       # Title of the report
      t.text :description   # Description of the report
      t.timestamps          # Automatically adds created_at and updated_at columns
    end
  end
end
