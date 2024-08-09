module Types
  module Input
    class ResponseInput < Types::BaseInputObject
      argument :question_id, ID, required: true
      argument :user_id, ID, required: true
      argument :response_text, String, required: true
    end
  end
end
