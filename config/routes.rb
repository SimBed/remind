Rails.application.routes.draw do
  root "birthdays#index"
  resources :birthdays, only: [ :index, :new, :create, :destroy ]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/warmup", to: proc { ActiveRecord::Base.connection.execute("SELECT 1")
                            [ 200, {}, [ "OK" ] ]
                          }, as: :ping_to_keep_app_awake
end
