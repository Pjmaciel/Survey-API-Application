module Types
  class Query < Types::BaseObject
    field :survey_results, [Types::SurveyResult], null: false do
      argument :survey_id, ID, required: true
      argument :filter_by_user, ID, required: false
      argument :filter_by_date, String, required: false
      argument :order_by, String, required: false, default_value: "created_at"
      argument :order_direction, String, required: false, default_value: "asc"
    end

    def survey_results(survey_id:, filter_by_user: nil, filter_by_date: nil, order_by: "created_at", order_direction: "asc")
      results = ::Survey.find(survey_id).responses

      results = results.where(user_id: filter_by_user) if filter_by_user.present?
      results = results.where("created_at::date = ?", filter_by_date) if filter_by_date.present?

      results.order("#{order_by} #{order_direction}")
    end
  end
end
