module Mutations
  class UpdateQuestion < Mutations::BaseMutation
    argument :question_id, ID, required: true
    argument :question_text, String, required: false
    argument :question_type, String, required: false

    type Types::Question

    def resolve(question_id:, question_text: nil, question_type: nil)
      question = Question.find(question_id)
      question.update!(
        question_text: question_text || question.question_text,
        question_type: question_type || question.question_type
      )
      question
    end
  end
end
