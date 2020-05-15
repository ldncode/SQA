Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  resources :questions, shallow: true do
    resources :answers
  end
end
