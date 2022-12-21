# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }

  it { should validate_length_of(:password).is_at_least(6) }

  describe "uniqueness" do 
    before :each do 
      create(:user)
    end
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  describe "is_password?" do
    let!(:user) {create(:user)}
    # why can the above be written in shorthand vs line 50

    context "with a valid password" do
      it "should return true" do
        expect(user.is_password?("password")).to be true
      end
    end

    context "with an invalid password" do
      it "should return false" do
        expect(user.is_password?("nutritiousnuts")).to be false
      end
    end
  end

  describe "password hashing" do
    it "does not save passwords to the database" do
      FactoryBot.create(:user, username: "Harry Potter")
      user = User.find_by(username: "Harry Potter")
      expect(user.password).not_to eq("password")
    end

    it "hashes password using BCrypt" do
      expect(BCrypt::Password).to receive(:create).with("asdflkj")
      FactoryBot.build(:user, password:"asdflkj")
    end
  end

  # users can sign up
  # users can log in
  # users can log out
  # users make goals
  # users can post comments on profiles (other users)
  # users can post comments on goals (thier own or others')

end
