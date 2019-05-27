Rails.application.routes.draw do
  resources :players

  resources :leagues do
    resources :teams
    resources :league_tournaments, path: "tournaments", as: "tournaments" do
      resources :leaderboards, path: "leaderboard"
    end
  end

  devise_for :users

  get 'welcome/index'

  root to: "leagues#index"
end
