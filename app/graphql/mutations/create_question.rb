module Mutations
  class CreateQuestion < Mutations::BaseMutation
    argument :survey_id, ID, required: true
    argument :question_text, String, required: true
    argument :question_type, String, required: true
    argument :required, Boolean, required: false, default_value: false

    type Types::Question

    def resolve(survey_id:, question_text:, question_type:, required:)
      survey = Survey.find(survey_id)
      Question.create!(
        survey: survey,
        question_text: question_text,
        question_type: question_type,
        required: required
      )
    end
  end
end
