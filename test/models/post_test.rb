# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  approvers        :text
#  body             :text
#  created_at       :datetime         not null
#  post_category_id :integer          not null
#  status           :string
#  title            :string
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#  voters           :text
#
# Indexes
#
#  index_posts_on_post_category_id  (post_category_id)
#  index_posts_on_user_id           (user_id)
#

require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
