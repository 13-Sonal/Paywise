class User < ApplicationRecord
  has_secure_password
  belongs_to :role
  validates :name, presence: true
  validates :role_id, presence: true
  validates :blood_group, presence: true
  validates :country_code, presence: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/,
              message: "must contain a valid email domain"
            }
  validates :password, presence: true

  def role_name
    role&.name&.strip
  end

  def has_role?(*role_names)
    role_names.include?(role_name)
  end

  # validates :primary_contact_number, presence: true
  # validates :emergency_contact_number, presence: true

  # validate :phone_numbers_match_country_format

  # enum :role, {
  #   admin: "admin",
  #   hr_manager: "hr_manager",
  #   hr: "hr"

  # }
  private

  def phone_numbers_match_country_format
    validate_phone_number(:primary_contact_number)
    validate_phone_number(:emergency_contact_number)
  end

  def validate_phone_number(attribute)
    phone_number = public_send(attribute)
    return if phone_number.blank?

    normalized_number = phone_number.gsub(/[\s()-]/, "")

    country_phone_formats = {
      "IN" => /\A\+91[6-9]\d{9}\z/,
      "US" => /\A\+1[2-9]\d{9}\z/,
      "CA" => /\A\+1[2-9]\d{9}\z/,
      "GB" => /\A\+447\d{9}\z/,
      "AU" => /\A\+614\d{8}\z/,
      "SG" => /\A\+65[3689]\d{7}\z/,
      "DE" => /\A\+49\d{7,13}\z/,
      "AE" => /\A\+971\d{8,9}\z/,
      "NL" => /\A\+31[1-9]\d{8}\z/,
      "FR" => /\A\+33[1-9]\d{8}\z/
    }

    phone_format = country_phone_formats[country_code]

    unless phone_format && normalized_number.match?(phone_format)
      errors.add(
        attribute,
        "is invalid for the selected country"
      )
    end
  end
end
