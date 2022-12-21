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
class User < ApplicationRecord

# F - Find_by_credentials
# I - is_password? +
# G - generate_session_token
# V - validates +
# A - attr_reader
# P - password=
# E - ensure_session_token
# B - before_validation
# R - reset_session_token
end
