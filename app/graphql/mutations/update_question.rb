module Mutations
  class UpdateQuestion < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :question_text, String, required: false
    argument :question_type, String, required: false
    argument :required, Boolean, required: false

    type Types::Question

    def resolve(id:, question_text: nil, question_type: nil, required: nil)
      question = Question.find(id)
      raise GraphQL::ExecutionError, "Question not found" if question.nil?

      question.update!(question_text: question_text, question_type: question_type, required: required)
      question
    end
  end
end
