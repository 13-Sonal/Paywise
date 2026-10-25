class CreateSalaryRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :salary_records do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :compensation
      t.string :currency
      t.date :effective_from

      t.timestamps
    end
  end
end
