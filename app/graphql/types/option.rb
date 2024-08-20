module Types
  class Option < Types::BaseObject
    field :id, ID, null: false
    field :option_text, String, null: false
  end
end
