module AuthHelpers
  def auth_headers(user)
    { "Authorization" => "Bearer #{JsonWebToken.encode(user.id)}" }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request

  # The JWT secret lives in development credentials only; specs use a fixed one.
  config.before do
    allow(Rails.application.credentials).to receive(:jwt_secret_key!).and_return("test-jwt-secret")
  end
end
