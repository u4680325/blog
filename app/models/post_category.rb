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

class PostCategory < ApplicationRecord
  has_many :posts

  serialize :approvers, type: Array, coder: YAML
  # Optional: set a default value in an `after_initialize` callback or use
  # a database default value (if using a more modern approach/Rails version)

  # A common pattern to ensure new records have an empty array by default:
  after_initialize do |post_category|
    post_category.approvers ||= []
  end
end
