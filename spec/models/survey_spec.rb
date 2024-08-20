require 'rails_helper'

RSpec.describe Survey, type: :model do
  # Testa validações
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password', role: 'coordinator')
      survey = Survey.new(title: 'Test Survey', user: user)
      expect(survey).to be_valid
    end

    it 'is not valid without a title' do
      user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password', role: 'coordinator')
      survey = Survey.new(user: user)
      expect(survey).not_to be_valid
      expect(survey.errors[:title]).to include("can't be blank")
    end

    it 'is not valid with a duplicate title for the same user' do
      user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password', role: 'coordinator')
      Survey.create!(title: 'Unique Title', user: user)
      duplicate_survey = Survey.new(title: 'Unique Title', user: user)
      expect(duplicate_survey).not_to be_valid
      expect(duplicate_survey.errors[:title]).to include("You already have a survey with this title")
    end

    it 'is not valid with more than 10 questions' do
      user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password', role: 'coordinator')
      survey = Survey.new(title: 'Test Survey', user: user)
      11.times { survey.questions.build(question_text: 'Sample Question', question_type: 'text') }
      expect(survey).not_to be_valid
      expect(survey.errors[:questions]).to include('cannot have more than 10 questions')
    end
  end

  # Testa associações
  describe 'associations' do
    it 'belongs to a user' do
      association = Survey.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many questions' do
      association = Survey.reflect_on_association(:questions)
      expect(association.macro).to eq :has_many
    end

    it 'has many responses through questions' do
      association = Survey.reflect_on_association(:responses)
      expect(association.macro).to eq :has_many
    end
  end

  # Testa enum
  describe 'enums' do
    it 'defines status as open, closed, and completed' do
      expect(Survey.statuses.keys).to contain_exactly('open', 'closed', 'completed')
    end
  end

  # Testa métodos auxiliares
  describe 'custom methods' do
    let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'password', role: 'coordinator') }
    let(:survey) { Survey.create!(title: 'Test Survey', user: user) }

    it 'can add questions' do
      survey.questions.create!(question_text: 'Sample Question', question_type: 'text')
      expect(survey.questions.count).to eq(1)
    end
  end
end
