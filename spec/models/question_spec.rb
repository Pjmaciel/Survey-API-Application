require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, user: user) }

  context 'validations' do
    it 'is valid with valid attributes' do
      options = [
        { option_text: 'Red' },
        { option_text: 'Blue' }
      ]
      question = build(:question, survey: survey, question_text: 'What is your favorite color?', question_type: 'multiple_choice', options_attributes: options)
      expect(question).to be_valid
    end

    it 'is invalid without a question_text' do
      question = build(:question, survey: survey, question_text: nil)
      expect(question).to_not be_valid
    end

    it 'is invalid without a question_type' do
      question = build(:question, survey: survey, question_type: nil)
      expect(question).to_not be_valid
    end

    it 'is invalid with too few options' do
      question = build(:question, survey: survey, question_text: 'What is your favorite color?', question_type: 'multiple_choice', options: [])
      expect(question).to_not be_valid
    end

    it 'is invalid with too few options' do
      question = build(:question, survey: survey, question_text: 'What is your favorite color?', question_type: 'multiple_choice', options_attributes: [])
      expect(question).to_not be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:survey) }
    it { should have_many(:options) }
  end
end
