require 'rails_helper'

RSpec.describe Mutations::AnswerSurvey, type: :request do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, status: 'open') }

  let!(:question1) do
    create(:question, survey: survey, question_type: 'checkbox', required: true, options_attributes: [
      { option_text: 'Option 1' },
      { option_text: 'Option 2' }
    ])
  end

  let!(:question2) do
    create(:question, survey: survey, question_type: 'checkbox', required: true, options_attributes: [
      { option_text: 'Option 1' },
      { option_text: 'Option 2' }
    ])
  end

  let(:query) do
    <<~GRAPHQL
      mutation($surveyId: ID!, $responses: [ResponseInput!]!) {
        answerSurvey(surveyId: $surveyId, responses: $responses) {
          id
          title
          status
        }
      }
    GRAPHQL
  end

  context 'when all required questions are answered' do
    it 'submits the survey and closes it' do
      variables = {
        surveyId: survey.id,
        responses: [
          { questionId: question1.id, responseText: 'Option 1' },
          { questionId: question2.id, responseText: 'Option 1' }
        ]
      }

      post '/graphql', params: { query: query, variables: variables.to_json }, headers: { 'Authorization': "Bearer #{user.id}" }

      json = JSON.parse(response.body)
      data = json['data']['answerSurvey']

      expect(data['status']).to eq('closed')
      expect(data['id']).to eq(survey.id.to_s)
      expect(data['title']).to eq(survey.title)
    end
  end

  context 'when a required question is not answered' do
    it 'returns an error' do
      variables = {
        surveyId: survey.id,
        responses: [
          { questionId: question1.id, responseText: 'Option 1' }
        ]
      }

      post '/graphql', params: { query: query, variables: variables.to_json }, headers: { 'Authorization': "Bearer #{user.id}" }

      json = JSON.parse(response.body)
      errors = json['errors']

      expect(errors).not_to be_nil
      expect(errors.first['message']).to include('mandatory and has not been answered')
    end
  end
end
