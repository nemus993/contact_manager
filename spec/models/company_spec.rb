require 'rails_helper'

RSpec.describe Company, type: :model do

  let(:company){ Company.create(name: "Kompanija")}

  it "is valid" do
    expect(company).to be_valid
  end
  it "is invalid without name" do
    company.name = nil
    expect(company).not_to be_valid
  end
  it "responds with its phone numbers when created" do
    company.phone_numbers.build(number: '000-1234')
    expect(company.phone_numbers.map(&:number)).to eq(['000-1234'])
  end
end
