# == Schema Information
#
# Table name: post_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  pattern    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  approvers  :text
#

require "test_helper"

class PostCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
