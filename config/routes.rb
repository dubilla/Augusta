Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :players

  resources :leagues do
    resources :teams
    resources :league_tournaments, path: "tournaments", as: "tournaments" do
      resources :leaderboards, path: "leaderboard"
    end
  end

  resources :drafts, only: :show
  resources :draft_picks, only: :index

  devise_for :users

  get 'welcome/index'

  root to: "leagues#index"
end
