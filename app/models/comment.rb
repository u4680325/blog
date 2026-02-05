# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  post_id    :integer          not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#

class Comment < ApplicationRecord
  belongs_to :post
  broadcasts_to :post
end
