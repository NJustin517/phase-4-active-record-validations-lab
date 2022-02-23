class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :click_bait_title

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def click_bait_title
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "Sorry, not click-baity enough")
    end
  end
end
