module Mutations
  class ReorderQuestions < Mutations::BaseMutation
    argument :survey_id, ID, required: true
    argument :question_orders, [ID], required: true

    type Types::Survey

    def resolve(survey_id:, question_orders:)
      survey = Survey.find(survey_id)

      ActiveRecord::Base.transaction do
        question_orders.each_with_index do |question_id, index|
          question = survey.questions.find(question_id)
          question.update!(position: index + 1)
        end
      end

      survey
    end
  end
end
