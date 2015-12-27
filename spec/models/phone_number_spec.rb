require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do

  let(:phone_number) { PhoneNumber.new(number: "111222333444", person_id: 1) }

  it "is valid" do
    expect(phone_number).to be_valid
  end
  it "is associated with person" do
    expect(phone_number).to respond_to(:person)
  end
  it "is invalid without number" do
    phone_number.number = nil
    expect(phone_number).not_to be_valid
  end
  it "should have reference to person" do
    phone_number.person_id = nil
    expect(phone_number).not_to be_valid
  end
end
