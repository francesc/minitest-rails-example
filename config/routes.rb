DummyMinitest::Application.routes.draw do
  resources :users
  resource :sessions

  root :to => "users#index"
end
