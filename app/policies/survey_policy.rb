# app/policies/survey_policy.rb
class SurveyPolicy < ApplicationPolicy
  def create?
    user.coordinator? || record.user_id == user.id
  end

  def update?
    Rails.logger.debug "User in SurveyPolicy#update?: #{user.inspect}"  # Adiciona depuração
    Rails.logger.debug "Survey in SurveyPolicy#update?: #{record.inspect}"  # Adiciona depuração

    user.coordinator? && record.user == user
  end

  def destroy?
    user.coordinator? && record.user == user
  end
end
