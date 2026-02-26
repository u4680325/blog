# == Schema Information
#
# Table name: post_categories
#
#  id         :integer          not null, primary key
#  approvers  :text
#  created_at :datetime         not null
#  name       :string
#  pattern    :string
#  updated_at :datetime         not null
#  voters     :text
#

require "test_helper"

class PostCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
