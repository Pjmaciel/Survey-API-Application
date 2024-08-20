module Mutations
  class CreateQuestion < Mutations::BaseMutation
    argument :survey_id, ID, required: true
    argument :question_text, String, required: true
    argument :question_type, String, required: true
    argument :options, [Types::Input::OptionInput], required: false

    type Types::Question

    def resolve(survey_id:, question_text:, question_type:, options: [])
      survey = Survey.find(survey_id)

      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized: User not found" unless user

      Rails.logger.debug "Current user: #{user.inspect}"
      Rails.logger.debug "Survey: #{survey.inspect}"

      policy = SurveyPolicy.new(user, survey)
      Rails.logger.debug "Policy check: #{policy.create?}"

      raise GraphQL::ExecutionError, "Not authorized" unless policy.create?

      question = survey.questions.create!(
        question_text: question_text,
        question_type: question_type,
        options_attributes: options.map { |opt| { option_text: opt.option_text } }
      )

      question
    end

  end
end
