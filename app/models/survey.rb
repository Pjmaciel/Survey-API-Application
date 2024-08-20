class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :responses, through: :questions

  validates :title, presence: true, uniqueness: { scope: :user_id, message: "You already have a survey with this title" }
  validate :questions_count_within_limit


  enum status: { open: 'open', closed: 'closed', completed: 'completed' }

  private

  def questions_count_within_limit
    if questions.size > 10
      errors.add(:questions, "cannot have more than 10 questions")
    end
  end
end
