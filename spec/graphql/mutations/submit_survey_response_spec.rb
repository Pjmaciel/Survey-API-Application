# spec/graphql/mutations/submit_survey_response_spec.rb
require 'rails_helper'

RSpec.describe Mutations::SubmitSurveyResponse, type: :request do
  let!(:coordinator) { create(:user, role: :coordinator) }
  let!(:respondent) { create(:user, role: :respondent) }
  let!(:survey) { create(:survey, user: coordinator, status: 'open') }
  let!(:question) { create(:question, survey: survey, required: true) }

  describe 'submitSurveyResponse mutation' do
    let(:query) do
      <<~GQL
        mutation($surveyId: ID!, $responses: [ResponseInput!]!) {
          submitSurveyResponse(surveyId: $surveyId, responses: $responses) {
            id
            responses {
              question {
                id
              }
              responseText
            }
            status
          }
        }
      GQL
    end

    context 'when the user is a respondent' do
      it 'completes the survey if all mandatory questions are answered' do
        response_input = [{ questionId: question.id, responseText: 'My Answer' }]

        result = SurveyApiApplicationSchema.execute(
          query,
          variables: { surveyId: survey.id, responses: response_input },
          context: { current_user: respondent }
        )

        json = result.to_h
        expect(json['data']['submitSurveyResponse']).not_to be_empty
        expect(survey.reload.status).to eq('completed')
      end

      it 'does not complete the survey if not all mandatory questions are answered' do
        response_input = []  # No answers

        result = SurveyApiApplicationSchema.execute(
          query,
          variables: { surveyId: survey.id, responses: response_input },
          context: { current_user: respondent }
        )

        json = result.to_h
        expect(json['data']).to be_nil
        expect(survey.reload.status).to eq('open')
      end
    end

    context 'when the user is not a respondent' do
      it 'returns an authorization error' do
        response_input = [{ questionId: question.id, responseText: 'My Answer' }]

        result = SurveyApiApplicationSchema.execute(
          query,
          variables: { surveyId: survey.id, responses: response_input },
          context: { current_user: coordinator }
        )

        json = result.to_h
        expect(json['errors']).not_to be_empty
        expect(json['errors'].first['message']).to eq('Not authorized')
      end
    end
  end
end

