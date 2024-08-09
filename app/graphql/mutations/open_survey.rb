module Mutations
  class OpenSurvey < Mutations::BaseMutation
    argument :survey_id, ID, required: true

    type Types::Survey

    def resolve(survey_id:)
      survey = Survey.find(survey_id)
      survey.update!(status: "open")
      survey
    end
  end
end

