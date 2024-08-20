class AddStatusToSurveys < ActiveRecord::Migration[7.1]
  def change
    add_column :surveys, :status, :string, default: "closed"
  end
end
