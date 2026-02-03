class Post < ApplicationRecord
  has_rich_text :body
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
