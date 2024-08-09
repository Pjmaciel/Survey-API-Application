module Types
  class Query < Types::BaseObject
    # Exemplo de campo para buscar uma pesquisa por ID
    field :survey, Types::Survey, null: true do
      argument :id, ID, required: true
    end

    def survey(id:)
      Survey.find(id)
    end

    # Adicione outros campos aqui para expor mais dados via queries
  end
end
