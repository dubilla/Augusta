Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :leagues do
    resources :teams
    resources :league_tournaments, path: "tournaments", as: "tournaments" do
      resources :leaderboards, path: "leaderboard", only: :index
    end
  end

  namespace :api do
    namespace :v1 do
      resources :rosters, only: :index
      resources :roster_players, only: :index
    end
  end

  devise_for :users

  get 'welcome/index'

  root to: "leagues#index"
end
