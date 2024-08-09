module Types
  class Response < Types::BaseObject
    field :id, ID, null: false
    field :response_text, String, null: false
    field :question, Types::Question, null: false
    field :user, Types::User, null: false
  end
end
