# What a service returns: either the objects it produced (in `data`), or the
# reasons it failed.
ServiceResult = Data.define(:success, :data, :errors) do
  def self.success(**data)
    new(success: true, data: data, errors: [])
  end

  def self.failure(errors)
    new(success: false, data: {}, errors: Array(errors))
  end

  def success?
    success
  end
end
