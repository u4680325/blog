# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  email_address   :string           not null
#  name            :string
#  password_digest :string           not null
#  updated_at      :datetime         not null
#  staff_id        :integer          default(0), not null
#  student_id      :integer          default(0), not null
#  role_id         :integer          default(0), not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts
  has_many :comments

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
