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
#  permits          :text
#  votes            :text
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
  has_many :comments, dependent: :destroy

  serialize :approvers, type: Array, coder: YAML
  serialize :permits, type: Array, coder: YAML
  serialize :voters, type: Array, coder: YAML
  serialize :votes, type: Array, coder: YAML
  # Optional: set a default value in an `after_initialize` callback or use
  # a database default value (if using a more modern approach/Rails version)

  # A common pattern to ensure new records have an empty array by default:
  after_initialize do |post|
    post.approvers ||= []
    post.permits ||= []
    post.voters ||= []
    post.votes ||= []
  end

  include AASM

  aasm :status, column: :status do
    state :pending, initial: true
    state :cancelled, :rejected, :approved, :achieved

    event :cancel do
      transitions from: [:pending], to: :cancelled
    end

    event :reject do
      transitions from: [:pending], to: :rejected
    end

    event :approve do
      transitions from: [:pending], to: :approved
    end

    event :achieve do
      transitions from: [:rejected, :approved], to: :achieved
    end
  end
end
