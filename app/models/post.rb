# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  body             :text
#  created_at       :datetime         not null
#  status           :string
#  title            :string
#  updated_at       :datetime         not null
#  post_category_id :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_posts_on_post_category_id  (post_category_id)
#  index_posts_on_user_id           (user_id)
#

class Post < ApplicationRecord
  has_rich_text :body
  belongs_to :post_category
  belongs_to :user
  has_many :comments

  include AASM

  aasm :status, column: :status do
    state :pending, initial: true
    state :cancelled, :rejected, :approved, :achieved

    event :cancel do
      transitions from: [:pending, :approved], to: :cancelled
    end

    event :reject do
      transitions from: [:pending, :achieved], to: :rejected
    end

    event :approve do
      transitions from: [:pending, :achieved], to: :approved
    end

    event :achieve do
      transitions from: [:rejected, :approved], to: :achieved
    end
  end
end
