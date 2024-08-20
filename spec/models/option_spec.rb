require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:survey) { create(:survey) }

  context 'validations' do
    it 'is valid with valid attributes' do
      question = create(:question, survey: survey)
      expect(question).to be_valid
    end

    it 'creates 3 options for the question' do
      question = create(:question, survey: survey)
      expect(question.options.count).to eq(3) # Verifica se 3 opções foram criadas
    end

    it 'is invalid with less than 1 option' do
      question = create(:question, survey: survey)
      question.options.destroy_all # Remove todas as opções
      expect(question).not_to be_valid
      expect(question.errors[:options]).to include('must have between 1 and 5 options')
    end

    it 'is invalid with more than 5 options' do
      question = create(:question, survey: survey)
      create_list(:option, 6, question: question) # Adiciona 6 opções
      expect(question).not_to be_valid
      expect(question.errors[:options]).to include('must have between 1 and 5 options')
    end
  end
end
