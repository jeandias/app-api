class User < ApplicationRecord
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validate :required_rules

  private

  def required_rules
    [
      {
        regex: /^(?=.*[a-z])(?=.*[A-Z])/,
        message: 'should have lower case and upper case words',
        op: nil
      },
      {
        regex: /\d/,
        message: 'should have at least 1 number',
        op: nil
      },
      {
        regex: /^(?=.*?[!@#$%&?*^-])/,
        message: 'should have at least 1 symbol',
        op: nil
      },
      {
        regex: /(.)\1{1,}/,
        message: 'should not contain sequence characters',
        op: '!'
      }
    ].each do |rule|
      condition = lambda { |x, y| "#{x}#{password.match?(y)}" }
      errors.add(:password, rule[:message]) unless condition.call(rule[:op], rule[:regex])
    end
  end
end
