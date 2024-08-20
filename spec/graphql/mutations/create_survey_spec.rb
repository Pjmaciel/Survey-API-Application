require 'rails_helper'

RSpec.describe Mutations::CreateSurvey, type: :request do
  let(:coordinator) { create(:user, role: :coordinator) }
  let(:respondent) { create(:user, role: :respondent) }

  let(:mutation) do
    <<-GQL
      mutation($title: String!, $questions: [QuestionInput!]!) {
        createSurvey(title: $title, questions: $questions) {
          id
          title
          status
          questions {
            id
            questionText
            options {
              id
              optionText
            }
          }
        }
      }
    GQL
  end

  let(:valid_variables) do
    {
      title: "Sample Survey",
      questions: [
        {
          questionText: "What is your favorite color?",
          questionType: "multiple_choice",
          options: [
            { optionText: "Red" },
            { optionText: "Blue" }
          ]
        }
      ]
    }
  end

  context 'when user is authorized' do
    before do
      post user_session_path, params: { user: { email: coordinator.email, password: coordinator.password } }
    end

    it 'creates a new survey with questions and options' do
      post graphql_path, params: { query: mutation, variables: valid_variables.to_json }

      json_response = JSON.parse(response.body)
      errors = json_response['errors']

      expect(errors).to be_nil
      survey_data = json_response.dig('data', 'createSurvey')
      expect(survey_data).not_to be_nil
      expect(survey_data['title']).to eq('Sample Survey')
      expect(survey_data['status']).to eq('open')
      expect(survey_data['questions'].size).to eq(1)
      expect(survey_data['questions'][0]['options'].size).to eq(2)
    end

    it 'returns an error if the title is blank' do
      invalid_variables = valid_variables.merge(title: "")

      post graphql_path, params: { query: mutation, variables: invalid_variables.to_json }

      json_response = JSON.parse(response.body)
      errors = json_response['errors']

      expect(errors.first['message']).to include("Title can't be blank")
    end

    it 'returns an error if the title is a duplicate' do
      post graphql_path, params: { query: mutation, variables: valid_variables.to_json }

      duplicate_variables = valid_variables.dup
      post graphql_path, params: { query: mutation, variables: duplicate_variables.to_json }

      json_response = JSON.parse(response.body)
      errors = json_response['errors']

      expect(errors.first['message']).to include("You already have a survey with this title")
    end
  end

  context 'when user is unauthorized' do
    before do
      delete destroy_user_session_path
      post user_session_path, params: { user: { email: respondent.email, password: respondent.password } }
    end

    it 'returns a not authorized error' do
      post graphql_path, params: { query: mutation, variables: valid_variables.to_json }

      json_response = JSON.parse(response.body)
      errors = json_response['errors']

      expect(errors.first['message']).to include('Not authorized')
    end
  end


end
