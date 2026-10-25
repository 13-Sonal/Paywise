# Base class for service objects: `SomeService.call(**args)` builds the
# service and runs it, so callers never deal with instances.
class ApplicationService
  def self.call(...)
    new(...).call
  end
end
