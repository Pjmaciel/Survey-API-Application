module Mutations
  class CloseSurvey < Mutations::BaseMutation
    argument :survey_id, ID, required: true

    type Types::Survey

    def resolve(survey_id:)
      survey = Survey.find(survey_id)
      survey.update!(status: "closed")
      survey
    end
  end
end
