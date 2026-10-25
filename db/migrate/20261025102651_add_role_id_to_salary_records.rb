class AddRoleIdToSalaryRecords < ActiveRecord::Migration[8.1]
  def change
    add_reference :salary_records, :role, foreign_key: true, index: true
  end
end
