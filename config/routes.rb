# config/routes.rb

Rails.application.routes.draw do
  devise_for :users

  # Permitir GET e POST na rota /graphql
  match "/graphql", to: "graphql#execute", via: [:post, :get]

  resources :surveys

  # Adicionar o GraphiQL para desenvolvimento
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root to: "home#index"
end
