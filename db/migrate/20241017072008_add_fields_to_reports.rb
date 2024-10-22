class AddFieldsToReports < ActiveRecord::Migration[7.2]
    def change
      add_column :reports, :title, :string unless column_exists?(:reports, :title)
      add_column :reports, :description, :text unless column_exists?(:reports, :description)
    end
end
