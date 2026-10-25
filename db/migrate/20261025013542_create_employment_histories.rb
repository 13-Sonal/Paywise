class CreateEmploymentHistories < ActiveRecord::Migration[8.1]
  def change
    create_table :employment_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.string :designation
      t.decimal :salary
      t.string :currency
      t.date :started_on
      t.date :ended_on

      t.timestamps
    end
  end
end
