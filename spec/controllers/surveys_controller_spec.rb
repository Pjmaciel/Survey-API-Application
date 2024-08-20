require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  let(:coordinator) { create(:user, role: :coordinator) }
  let!(:survey) { create(:survey, user: coordinator) } # Cria uma pesquisa antes do teste

  describe 'GET #index' do
    before do
      sign_in coordinator
      get :index
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe 'POST #create' do
    before do
      sign_in coordinator
    end

    it 'creates a new survey' do
      expect {
        post :create, params: { survey: { title: 'New Survey', status: 'open' } }
      }.to change(Survey, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT #update' do
    before do
      sign_in coordinator
    end

    it 'updates the survey' do
      put :update, params: { id: survey.id, survey: { title: 'Updated Title' } }
      expect(response).to have_http_status(:ok)
      survey.reload
      expect(survey.title).to eq('Updated Title')
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in coordinator
    end

    it 'deletes the survey' do
      expect {
        delete :destroy, params: { id: survey.id }
      }.to change(Survey, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
