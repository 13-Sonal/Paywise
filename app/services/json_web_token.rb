class JsonWebToken
  ALGORITHM = "HS256"
  EXPIRATION_TIME = 15.minutes

  class << self
    def encode(user_id)
      payload = {
        user_id: user_id,
        exp: EXPIRATION_TIME.from_now.to_i
      }

      JWT.encode(
        payload,
        secret_key,
        ALGORITHM
      )
    end

    def decode(token)
      decoded_payload = JWT.decode(
        token,
        secret_key,
        true,
        algorithm: ALGORITHM
      ).first

      decoded_payload.with_indifferent_access
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end

    private

    def secret_key
      Rails.application.credentials.jwt_secret_key!
    end
  end
end