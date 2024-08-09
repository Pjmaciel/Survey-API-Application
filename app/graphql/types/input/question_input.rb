module Types
  module Input
    class QuestionInput < Types::BaseInputObject  # Renomeado para QuestionInput
      argument :question_text, String, required: true
      argument :question_type, String, required: true
      argument :options, [Types::Input::OptionInput], required: true
    end
  end
end
