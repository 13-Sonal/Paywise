class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.references :role, null: false, foreign_key: true
      t.date :hire_date
      t.string :country_code
      t.string :primary_contact_number
      t.string :emergency_contact_number
      t.text :address
      t.string :blood_group

      t.timestamps
    end
  end
end
