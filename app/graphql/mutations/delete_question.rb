module Mutations
  class DeleteQuestion < Mutations::BaseMutation
    argument :question_id, ID, required: true

    type Types::Question

    def resolve(question_id:)
      question = Question.find(question_id)
      question.destroy
      question
    end
  end
end
