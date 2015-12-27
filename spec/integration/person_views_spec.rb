require 'rails_helper'

describe 'the person view', type: :feature do

  before(:all) do
    @person = Person.create(first_name: "John", last_name: "Doe")
  end

  before (:each) do
    @person.phone_numbers.create(number: "111-2345")
    @person.phone_numbers.create(number: "222-2345")
    @person.email_addresses.create(address: "1234@example.com")
    @person.email_addresses.create(address: "john@example.com")
    visit person_path(@person)
  end
  context 'for managing phone numbers' do
    it 'shows all phone numbers' do
      @person.phone_numbers.each do |num|
        expect(page).to have_content(num.number)
      end
    end
    it 'has a link to create new numbers' do
      expect(page).to have_link('Add number', href: new_phone_number_path(person_id: @person.id))
    end
    it 'adds a new phone number' do
      page.click_link('Add number')
      page.fill_in('Number', :with => "000-1234")
      page.click_button('Create number')
      expect(current_path).to eq(person_path(@person))
      expect(page).to have_content("000-1234")
    end
    it 'has a link to edit phone numbers' do
      @person.phone_numbers.each do |phone|
        expect(page).to have_link('Edit', href: edit_phone_number_path(phone))
      end
    end
    it 'edits the phone number' do
      phone = @person.phone_numbers.first
      old_number = phone.number

      first(:link, 'Edit').click
      page.fill_in('Number', :with => "666-6666")
      page.click_button('Update phone number')
      expect(current_path).to eq(person_path(@person))
      expect(page).to have_content("666-6666")
      expect(page).not_to have_content(old_number)
    end
    it 'has a link to delete phone number' do
      @person.phone_numbers.each do |phone|
        expect(page).to have_link('Delete', href: phone_number_path(phone))
      end
    end
    it 'deletes phone number' do
      phone = @person.phone_numbers.first
      number = phone.number

      first(:link, 'Delete').click
      expect(page).not_to have_content(number)
    end
  end
  context 'for managing email addresses' do
    it 'list all email addresses' do
      @person.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end
    it 'has a link for new email address' do
      expect(page).to have_link('Add email', href: new_email_address_path(person_id: @person.id))
    end
    it 'adds new email address to person' do
      page.click_link('Add email')
      expect(current_path).to eq(new_email_address_path)
      page.fill_in('Address', :with => "new@example.com")
      page.click_button('Create email')
      expect(current_path).to eq(person_path(@person))
      expect(page).to have_content("new@example.com")
    end
    it 'has a link to edit email addresses' do
      @person.email_addresses.each do |email|
        expect(page).to have_link('Edit', href: edit_email_address_path(email))
      end
    end
    it 'updates email address information' do
      email = @person.email_addresses.first
      old_email = email.address

      within('ul.email_addresses') do
      first(:link, 'Edit').click
      end
      expect(current_path).to eq(edit_email_address_path(email))
      page.fill_in('Address', :with => "new@example.com")
      page.click_button('Update email')
      expect(current_path).to eq(person_path(@person))
      expect(page).not_to have_content(old_email)
    end
    it 'has link for deleting email' do
      @person.email_addresses.each do |email|
        expect(page).to have_link('Delete', href: email_address_path(email))
      end
    end
    it 'destroys an email address' do
      email = @person.email_addresses.first
      address = email.address

      within('ul.email_addresses') do
        first(:link, 'Delete').click
      end
      expect(current_path).to eq(person_path(@person))
      expect(page).not_to have_content(address)
    end
  end
end
