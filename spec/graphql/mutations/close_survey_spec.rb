# spec/requests/close_survey_spec.rb
require 'rails_helper'

RSpec.describe Mutations::CloseSurvey, type: :request do
  let!(:coordinator) { create(:user, role: :coordinator) }
  let!(:respondent) { create(:user, role: :respondent) }
  let!(:survey) { create(:survey, user: coordinator, status: 'open') }

  describe 'closeSurvey mutation' do
    let(:query) do
      <<~GQL
        mutation($id: ID!) {
          closeSurvey(id: $id) {
            id
            title
            status
          }
        }
      GQL
    end

    context 'when the user is a coordinator' do
      it 'closes the survey' do
        result = SurveyApiApplicationSchema.execute(
          query,
          variables: { id: survey.id },
          context: { current_user: coordinator }
        )

        json = result.to_h
        data = json['data']['closeSurvey']

        expect(data['id'].to_i).to eq(survey.id)
        expect(data['status']).to eq('closed')
      end
    end

    context 'when the user is not a coordinator' do
      it 'returns an authorization error' do
        result = SurveyApiApplicationSchema.execute(
          query,
          variables: { id: survey.id },
          context: { current_user: respondent }
        )

        json = result.to_h
        errors = json['errors'] || []
        expect(errors).not_to be_empty
        expect(errors.first['message']).to eq('Not authorized')
      end
    end

    context 'when the survey is already closed' do
      before { survey.update!(status: 'closed') }

      it 'returns an error indicating the survey is already closed' do
        result = SurveyApiApplicationSchema.execute(
          query,
          variables: { id: survey.id },
          context: { current_user: coordinator }
        )

        json = result.to_h
        errors = json['errors'] || []
        expect(errors).not_to be_empty
        expect(errors.first['message']).to eq('Survey is already closed')
      end
    end
  end
end
