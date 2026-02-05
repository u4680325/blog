# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  email_address   :string           not null
#  password_digest :string           not null
#  updated_at      :datetime         not null
#  name            :string
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
