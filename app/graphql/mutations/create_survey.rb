# app/graphql/mutations/create_survey.rb
module Mutations
  class CreateSurvey < Mutations::BaseMutation
    argument :title, String, required: true

    type Types::Survey

    def resolve(title:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user.coordinator?

      Survey.create!(title: title, user: user)
    end
  end
end
