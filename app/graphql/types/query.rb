module Types
  class Query < Types::BaseObject
    field :survey, Types::Survey, null: true do
      argument :id, ID, required: true
    end

    def survey(id:)
      Survey.find(id)
    end

  end
end
