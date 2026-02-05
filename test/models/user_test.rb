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

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end
end
