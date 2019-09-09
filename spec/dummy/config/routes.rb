Rails.application.routes.draw do
  resources :users do
    member do
      put :move
    end
  end
end
