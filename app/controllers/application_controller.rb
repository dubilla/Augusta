class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  def after_sign_in_path_for resource
    league_team_path(current_user.team.league, current_user.team) || root_path
  end
end
