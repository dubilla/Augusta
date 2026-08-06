require "rails_helper"

# Smoke coverage for ActiveAdmin — the app's largest untested surface.
# AA failures (bad Ransack filters, arbre/formtastic breakage) surface at
# request time, not boot, so a green model suite says nothing about them.
# These specs render every admin index for a signed-in admin and exercise the
# Ransack query path that powers AA filters. They are the automated guard for
# the Ransack 4 allowlist change coming in a later upgrade stage.
RSpec.describe "ActiveAdmin smoke", type: :request do
  include Devise::Test::IntegrationHelpers

  before { sign_in create(:admin_user) }

  # Every registered admin index should render for a signed-in admin.
  %w[
    /admin
    /admin/dashboard
    /admin/admin_users
    /admin/comments
    /admin/league_tournaments
    /admin/rosters
    /admin/teams
    /admin/tournaments
  ].each do |path|
    it "GET #{path} returns 200" do
      get path
      expect(response).to have_http_status(:ok)
    end
  end

  # Applying a filter builds a Ransack query; this is the surface that breaks
  # silently at query time when models lack ransackable allowlists (Ransack 4).
  it "applies a Ransack filter on an index without error" do
    create(:team)
    get "/admin/teams", params: { q: { id_eq: Team.first.id } }
    expect(response).to have_http_status(:ok)
  end
end
