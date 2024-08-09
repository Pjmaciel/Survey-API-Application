class SurveyApiApplicationSchema < GraphQL::Schema
  mutation(Types::Mutation)
  query(Types::Query)  # Referência ao novo tipo Query
end
