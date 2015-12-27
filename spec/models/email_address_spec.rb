require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
    let(:email_address){EmailAddress.new(address: "nnn@example.com", person_id: 1)}

    it "is valid" do
      expect(email_address).to be_valid
    end
    it "is associated with person" do
      expect(email_address).to respond_to(:person)
    end
    it "is invalid without email address" do
      email_address.address = nil
      expect(email_address).not_to be_valid
    end
    it "should have reference to person" do
      email_address.person_id = nil
      expect(email_address).not_to be_valid
    end
end
