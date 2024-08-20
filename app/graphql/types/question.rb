module Types
  class Question < Types::BaseObject
    field :id, ID, null: false
    field :question_text, String, null: false
    field :question_type, String, null: false
    field :options, [Types::Option], null: true
  end
end
