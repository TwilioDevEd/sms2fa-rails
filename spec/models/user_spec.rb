describe User do
    it "doesnt allow duplicated email addresses" do
        valid_user_attributes = {
            first_name: 'bob',
            last_name: 'martin',
            email: 'bob@martin.com',
            phone_number: '+1-555-5555',
            password: 'very-secret-password'
        }
        User.create(valid_user_attributes)
        user = User.new(first_name: 'Bob', last_name: 'Jobs', email: 'bob@martin.com', password: 'another-bob')

        user.valid?

        expect(user.errors[:email]).to include("has already been taken")
    end
end
