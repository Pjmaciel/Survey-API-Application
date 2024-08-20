module Types
  class User < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :role, String, null: false
    field :surveys, [Types::Survey], null: true
  end
end
