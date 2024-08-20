class Question < ApplicationRecord
  belongs_to :survey
  has_many :options, dependent: :destroy
  has_many :responses, dependent: :destroy

  validate :validate_options_count

  accepts_nested_attributes_for :options, allow_destroy: true

  private

  def validate_options_count
      if options.size < 1 || options.size > 5
        errors.add(:options, 'must have between 1 and 5 options')
      end
    end
end
