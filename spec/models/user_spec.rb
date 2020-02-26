require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(username: "app-api", password: "Pas!123")
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with custom messages" do
      subject.password = "12345"

      expect(subject).to_not be_valid
      expect(subject.errors.messages[:password]).to eq [
                                                         "is too short (minimum is 6 characters)",
                                                         "should have lower case and upper case words",
                                                         "should have at least 1 symbol"
                                                       ]
    end

    it "is not valid without at least 1 symbol" do
      subject.password = "Ab12345"

      expect(subject).to_not be_valid
      expect(subject.errors.messages[:password]).to eq ["should have at least 1 symbol"]
    end

    it "is not valid when contain sequence characters" do
      subject.password = "Aa1w@@w"

      expect(subject).to_not be_valid
      expect(subject.errors.messages[:password]).to eq ["should not contain sequence characters"]
    end
  end
end
