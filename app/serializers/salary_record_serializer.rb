# JSON shape of a salary record in API responses.
class SalaryRecordSerializer
  def self.collection(records)
    records.map { |record| new(record).as_json }
  end

  def initialize(salary_record)
    @salary_record = salary_record
  end

  def as_json(*)
    {
      id: @salary_record.id,
      user_id: @salary_record.user_id,
      role_id: @salary_record.role_id,
      compensation: @salary_record.compensation,
      currency: @salary_record.currency,
      effective_from: @salary_record.effective_from,
      created_at: @salary_record.created_at,
      updated_at: @salary_record.updated_at,
      role: role_json
    }
  end

  private

  def role_json
    role = @salary_record.role
    role && { id: role.id, name: role.name }
  end
end
