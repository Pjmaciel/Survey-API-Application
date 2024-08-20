require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'Test User', email: 'test@example.com', password: 'password', role: 'coordinator')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(email: 'test@example.com', password: 'password', role: 'coordinator')
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(name: 'Test User', password: 'password', role: 'coordinator')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(name: 'Test User', email: 'test@example.com', role: 'coordinator')
      expect(user).not_to be_valid
    end

    it 'is not valid without a role' do
      user = User.new(name: 'Test User', email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
    end
  end

  # Teste de enums
  describe 'roles' do
    it 'allows creating a coordinator user' do
      user = User.new(name: 'Coordinator', email: 'coordinator@example.com', password: 'password', role: 'coordinator')
      expect(user).to be_valid
      expect(user.coordinator?).to be(true)
    end

    it 'allows creating a respondent user' do
      user = User.new(name: 'Respondent', email: 'respondent@example.com', password: 'password', role: 'respondent')
      expect(user).to be_valid
      expect(user.respondent?).to be(true)
    end

    it 'does not allow an invalid role' do
      expect {
        User.new(name: 'Invalid', email: 'invalid@example.com', password: 'password', role: 'invalid_role')
      }.to raise_error(ArgumentError)
    end
  end

  # Teste de métodos auxiliares
  describe 'role methods' do
    let(:coordinator) { User.create!(name: 'Coordinator User', email: 'coordinator@example.com', password: 'password', role: 'coordinator') }
    let(:respondent) { User.create!(name: 'Respondent User', email: 'respondent@example.com', password: 'password', role: 'respondent') }

    it 'returns true for coordinator? if user is a coordinator' do
      expect(coordinator.coordinator?).to be(true)
    end

    it 'returns false for coordinator? if user is a respondent' do
      expect(respondent.coordinator?).to be(false)
    end

    it 'returns true for respondent? if user is a respondent' do
      expect(respondent.respondent?).to be(true)
    end

    it 'returns false for respondent? if user is a coordinator' do
      expect(coordinator.respondent?).to be(false)
    end
  end
end
