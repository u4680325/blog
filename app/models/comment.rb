# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  post_id    :integer          not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  broadcasts_to :post
end
