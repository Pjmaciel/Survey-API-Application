module Types
  module Input
    class OptionInput < Types::BaseInputObject
      argument :option_text, String, required: true
    end
  end
end
