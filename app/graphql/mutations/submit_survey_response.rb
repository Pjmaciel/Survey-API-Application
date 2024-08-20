# app/graphql/mutations/submit_survey_response.rb
module Mutations
  class SubmitSurveyResponse < Mutations::BaseMutation
    argument :survey_id, ID, required: true
    argument :responses, [Types::Input::ResponseInput], required: true

    type [Types::Response]

    def resolve(survey_id:, responses:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user.respondent?

      survey = Survey.find(survey_id)
      raise GraphQL::ExecutionError, "Survey not found" if survey.nil? || survey.closed?

      created_responses = responses.map do |response|
        question = survey.questions.find(response.question_id)
        user.responses.create!(
          question: question,
          response_text: response.response_text
        )
      end

      # Verificar se todas as perguntas obrigatórias foram respondidas
      all_questions_answered = survey.questions.all? do |question|
        !question.required? || created_responses.any? { |response| response.question_id == question.id }
      end

      # Marcar a pesquisa como "completa" se todas as perguntas obrigatórias foram respondidas
      if all_questions_answered
        survey.update!(status: 'completed')
      end

      created_responses
    end
  end
end
