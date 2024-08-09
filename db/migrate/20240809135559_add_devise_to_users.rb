class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      # Remova ou comente as linhas que adicionam colunas que já existem
      # t.timestamps null: false  # Comente esta linha se `created_at` e `updated_at` já existem

      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end

    add_index :users, :reset_password_token, unique: true
  end
end
