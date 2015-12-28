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
  it "responds with its phone numbers" do
    person.phone_numbers.build(number: "555-1234")
    expect(person.phone_numbers.map(&:number)).to eq(['555-1234'])
  end
  it "has many email addresses" do
    person.email_addresses.build(address: "mail@example.com")
    expect(person.email_addresses.map(&:address)).to eq(['mail@example.com'])
  end
end
