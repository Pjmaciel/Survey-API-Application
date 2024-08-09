module Mutations
  class CreateSurvey < Mutations::BaseMutation
    argument :title, String, required: true
    argument :user_id, ID, required: true
    argument :questions, [Types::Input::QuestionInput], required: true

    type Types::Survey

    def resolve(title:, user_id:, questions:)
      user = User.find(user_id)
      survey = user.surveys.create!(title: title)
      questions.each do |question_input|
        survey.questions.create!(
          question_text: question_input.question_text,
          question_type: question_input.question_type,
          options_attributes: question_input.options.map { |opt| { option_text: opt.option_text } }
        )
      end
      survey
    end
  end
end
