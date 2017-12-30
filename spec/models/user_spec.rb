require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:stories).dependent(:destroy) }
  it { should have_many(:user_followers).dependent(:destroy) }
  user = User.new
  it "is not valid without a username" do expect(user).to_not be_valid end
  it "is not valid without an email" do expect(user).to_not be_valid end
  it "is not valid without a password" do expect(user).to_not be_valid end
  it "should able to follow another user" do
    bob = User.new(username: "bob", email: "bob@email.com", password: "123")
    sam = User.new(username: "sam", email: "sam@email.com", password: "123")
    bob.followers << sam
    expect(bob.followers).to_not be_nil
  end

end
