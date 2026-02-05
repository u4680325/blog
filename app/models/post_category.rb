# == Schema Information
#
# Table name: post_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  pattern    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostCategory < ApplicationRecord
  has_many :posts
end
