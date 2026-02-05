# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  ip_address :string
#  updated_at :datetime         not null
#  user_agent :string
#  user_id    :integer          not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#

class Session < ApplicationRecord
  belongs_to :user
end
