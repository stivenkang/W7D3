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

  describe 'uniqueness' do 
    before :each do 
      create(:user)
    end
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end


  # users can sign up
  # users can log in
  # users can log out
  # users make goals
  # users can post comments on profiles (other users)
  # users can post comments on goals (thier own or others')


end
