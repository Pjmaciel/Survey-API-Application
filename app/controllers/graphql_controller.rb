class GraphqlController < ApplicationController
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    context = {
      current_user: User.first
    }

    # Execute a query antes de logar o resultado
    result = SurveyApiApplicationSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )

    # Mova os logs para depois da definição de result
    Rails.logger.debug "GraphQL Result: #{result.to_h.inspect}"
    Rails.logger.debug "Current user: #{context[:current_user].inspect}"

    render json: result
  rescue Pundit::NotAuthorizedError => e
    render json: { errors: [{ message: "Not authorized: #{e.message}" }] }, status: :forbidden
  rescue => e
    render json: { errors: [{ message: e.message }] }, status: 500
  end

  private

  def prepare_variables(variables_param)
    case variables_param
    when String
      variables_param.present? ? JSON.parse(variables_param) : {}
    when Hash, ActionController::Parameters
      variables_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end
end
