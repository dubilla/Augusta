require "rails_helper"

# Smoke coverage for ActiveAdmin — the app's largest untested surface.
# AA failures (bad Ransack filters, arbre/formtastic breakage) surface at
# request time, not boot, so a green model suite says nothing about them.
# These specs render every admin index for a signed-in admin, exercise the
# Ransack query path that powers AA filters, and render the new/edit forms
# (Formtastic). They are the automated guard for the ActiveAdmin 3 / Ransack 4 /
# Formtastic 5 upgrade (Stage 5b).
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

  # `new` forms render the Formtastic inputs (incl. belongs_to association
  # selects) — the surface most likely to break on the Formtastic 5 bump.
  %w[
    /admin/admin_users/new
    /admin/league_tournaments/new
    /admin/rosters/new
    /admin/teams/new
    /admin/tournaments/new
  ].each do |path|
    it "GET #{path} renders the form (200)" do
      get path
      expect(response).to have_http_status(:ok)
    end
  end

  # The Roster edit form renders `f.has_many` with a persisted child plus the
  # allow_destroy checkbox — a nested-form path `/new` never exercises, and the
  # most likely place Formtastic 4→5 breakage would hide.
  it "GET /admin/rosters/:id/edit renders the nested form (200)" do
    roster = create(:roster)
    create(:roster_player, roster: roster)
    get "/admin/rosters/#{roster.id}/edit"
    expect(response).to have_http_status(:ok)
  end
end
