module Mutations
  class CreateOption < Mutations::BaseMutation
    argument :question_id, ID, required: true
    argument :option_text, String, required: true

    type Types::Option

    def resolve(question_id:, option_text:)
      question = Question.find(question_id)
      raise GraphQL::ExecutionError, "Question not found" if question.nil?

      option = question.options.create!(option_text: option_text)
      option
    end
  end
end
