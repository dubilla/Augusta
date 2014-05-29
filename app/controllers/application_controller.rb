class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for resource
    team_path current_user.team || root_path
  end
end
