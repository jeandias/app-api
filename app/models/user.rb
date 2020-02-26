class User < ApplicationRecord
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validate :required_rules

  private

  def required_rules
    return if password.nil?

    [
      {
        match: password.match?(/^(?=.*[a-z])(?=.*[A-Z])/),
        message: 'should have lower case and upper case words'
      },
      {
        match: password.match?(/\d/),
        message: 'should have at least 1 number'
      },
      {
        match: password.match?(/^(?=.*?[!@#$%&?*^-])/),
        message: 'should have at least 1 symbol'
      },
      {
        match: password.match(/(.)\1{1,}/).nil?,
        message: 'should not contain sequence characters'
      }
    ].each do |rule|
      errors.add(:password, rule[:message]) unless rule[:match]
    end
  end
end
