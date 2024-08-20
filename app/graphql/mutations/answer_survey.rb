module Mutations
  class AnswerSurvey < Mutations::BaseMutation
    argument :survey_id, ID, required: true
    argument :responses, [Types::Input::ResponseInput], required: true

    type Types::Survey

    def resolve(survey_id:, responses:)
      survey = Survey.find(survey_id)

      answers = {}

      responses.each do |response_input|
        user = context[:current_user]
        question = survey.questions.find(response_input.question_id)
        validate_response(question, response_input.response_text)

        answers[question.id] = Response.create!(
          question: question,
          user: user,
          response_text: response_input.response_text
        )
      end

      # Verifica se todas as perguntas obrigatórias foram respondidas
      survey.questions.each do |question|
        if question.required? && !answers.key?(question.id)
          raise GraphQL::ExecutionError, "The question #{question.id} is mandatory and has not been answered."
        end
      end

      # Atualiza o status da pesquisa, sem tentar atualizar o título
      survey.update_columns(status: 'closed')

      survey
    end

    private

    def validate_response(question, response_text)
      case question.question_type
      when 'radio', 'checkbox'
        valid_option = question.options.pluck(:option_text).include?(response_text)
        raise GraphQL::ExecutionError, "Invalid answer to the question #{question.id}" unless valid_option
      when 'text'
        raise GraphQL::ExecutionError, "Text response cannot be blank" if response_text.blank?
      else
        raise GraphQL::ExecutionError, "Unknown question type"
      end
    end
  end
end
