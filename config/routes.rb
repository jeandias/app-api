Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "users/validate_password", to: "users#validate_password"
    end
  end
end
