module Types
  class Survey < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :questions, [Types::Question], null: true
    field :user, Types::User, null: false

    def questions
      object.questions.includes(:responses)
    end

  end
end
