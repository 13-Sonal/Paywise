class CreatePastChecks < ActiveRecord::Migration[8.1]
  def change
    create_table :past_checks do |t|
      t.references :employment_history, null: false, foreign_key: true
      t.jsonb :audited_changes
      t.datetime :audited_at

      t.timestamps
    end
  end
end
