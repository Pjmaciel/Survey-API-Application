module Types
  class Survey < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :user, Types::User, null: false
    field :questions, [Types::Question], null: true
  end
end
