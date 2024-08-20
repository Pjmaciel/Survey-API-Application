# app/models/response.rb
class Response < ApplicationRecord
  belongs_to :survey
  belongs_to :user
  belongs_to :question

  validates :response_text, presence: true

  validates :response_text, presence: true


  validate :validate_response_text_for_question_type

  private

  def validate_response_text_for_question_type
    if question.question_type == 'checkbox' || question.question_type == 'multiple_choice'
      valid_options = question.options.pluck(:option_text)
      response_array = response_text.split(",")
      response_array.each do |response|
        errors.add(:response_text, "Invalid response selected") unless valid_options.include?(response.strip)
      end
    end
  end
end
