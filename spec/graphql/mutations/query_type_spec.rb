# spec/graphql/types/query_spec.rb
require 'rails_helper'

RSpec.describe 'SubmitSurveyResponse', type: :request do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, user: user, status: 'open') }
  let(:question) { create(:question, survey: survey) }

  it 'allows a user to submit a survey response' do
    post '/graphql', params: {
      query: <<~GQL
        mutation {
          submitSurveyResponse(surveyId: "#{survey.id}", responses: [
            { questionId: "#{question.id}", responseText: "My Answer" }
          ]) {
            id
            responses {
              question {
                id
              }
              responseText
            }
          }
        }
      GQL
    }, headers: { 'Authorization' => "Bearer #{user.id}" }

    json = JSON.parse(response.body)
    expect(response).to have_http_status(:success)
    expect(json['data']['submitSurveyResponse']['responses']).to include(
                                                                   'responseText' => 'My Answer'
                                                                 )
  end
end
