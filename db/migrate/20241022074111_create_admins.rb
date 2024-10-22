class CreateAdmins < ActiveRecord::Migration[7.2]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :position
      t.string :department
      t.string :email
      t.string :phone_number
      t.date :date_of_birth
      t.string :salary
      t.string :address
      t.string :user_id

      t.timestamps
    end
  end
end
