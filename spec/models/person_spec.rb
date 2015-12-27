require 'rails_helper'

RSpec.describe Person, type: :model do

  let(:person) do
    Person.create(first_name: "John", last_name: "Doe")
  end

  it "is valid" do
    expect(person).to be_valid
  end
  it "is invalid without first name" do
    person.first_name = nil
    expect(person).not_to be_valid
  end
  it "is invalid without last name" do
    person.last_name = nil
    expect(person).not_to be_valid
  end
  it "has many phone numbers" do
    expect(person.phone_numbers).to eq([])
  end
  it "has many email addresses" do
    expect(person.email_addresses).to eq([])
  end
end
