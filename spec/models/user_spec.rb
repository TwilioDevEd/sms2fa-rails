require 'rails_helper'

describe User do
  it "does not allow duplicate email addresses" do
    create(:user, email: 'bob@example.com')

    user = build(:user, email: 'bob@example.com')
    user.valid?

    expect(user.errors[:email]).to include("has already been taken")
  end

  describe '#pretty_phone_number' do
    it 'formats the phone number' do
      user = create(:user)
      expect(user.phone_number).to eq('+12025550131')
      expect(user.pretty_phone_number).to eq('+1 (202) 555-0131')
    end
  end
end
