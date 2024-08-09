module Types
  class Question < Types::BaseObject
    field :id, ID, null: false
    field :question_text, String, null: false
    field :question_type, String, null: false
    field :survey, Types::Survey, null: false
    field :options, [Types::Option], null: true
    field :responses, [Types::Response], null: true
    field :required, Boolean, null: false

    def responses
      object.responses
    end
  end
end
