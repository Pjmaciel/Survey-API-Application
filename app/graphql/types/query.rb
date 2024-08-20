# app/graphql/types/query.rb
module Types
  class Query < Types::BaseObject
    field :surveys, [Types::Survey], null: false do
      description "Fetch all surveys for the current user"
    end

    field :survey, Types::Survey, null: false do
      argument :id, ID, required: true
      description "Fetch a single survey by ID"
    end

    field :closed_surveys, [Types::Survey], null: false do
      description "Fetch all closed surveys accessible by the current user"
    end

    def surveys
      context[:current_user].surveys
    end

    def survey(id:)
      context[:current_user].surveys.find(id)
    end

    def closed_surveys
      user = context[:current_user]

      if user.coordinator?
        Survey.where(status: 'closed')
      else
        Survey.joins(:responses).where(status: 'closed', responses: { user_id: user.id }).distinct
      end
    end
  end
end
