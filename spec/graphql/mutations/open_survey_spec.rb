# spec/requests/open_survey_spec.rb
require 'rails_helper'

RSpec.describe Mutations::OpenSurvey, type: :request do
  let!(:coordinator) { create(:user, role: :coordinator) }
  let!(:respondent) { create(:user, role: :respondent) }
  let!(:survey) { create(:survey, user: coordinator, status: 'closed') }

  describe 'openSurvey mutation' do
    let(:query) do
      <<~GQL
        mutation($id: ID!) {
          openSurvey(id: $id) {
            id
            title
            status
          }
        }
      GQL
    end

    context 'when the user is not a coordinator' do
      it 'returns an authorization error' do
        # Passa explicitamente o `current_user` como o `respondent`
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
  end
end
