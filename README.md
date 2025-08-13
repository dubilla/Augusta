# Augusta

Augusta (aka "Augusta Peaches") is a lightweight fantasy golf league and live leaderboard built with Ruby on Rails and React. Users belong to a league, teams are associated with users, and for each PGA tournament a league creates a set of rosters (foursomes). The app shows live team and player leaderboards using data fetched from ESPN.

## Features

- Leagues and teams
  - `League` has many `Teams`
  - Each `Team` belongs to a `User`
- Tournaments and league tournaments
  - `Tournament` (name, start_date, external_id, completed)
  - `LeagueTournament` joins a `League` to a `Tournament`
  - "Active" tournament logic based on start date and completion
- Rosters and scoring
  - `Roster` belongs to `Team` and `LeagueTournament`
  - `RosterPlayer` links a `Player` to a `Roster`
  - Live scores and statuses are fetched from ESPN and cached
- Live leaderboards (React)
  - Team leaderboard and Player leaderboard poll JSON:API endpoints every 60 seconds
  - Tailwind CSS for styling
- Admin
  - ActiveAdmin for managing Tournaments and League Tournaments
  - Devise for `User` and `AdminUser` authentication
- API
  - JSON:API responses for leaderboards consumed by the React UI

## Tech stack

- Ruby 2.6.6, Rails 5.x
- PostgreSQL
- Webpacker, React 17, Tailwind CSS (PostCSS 7 compat)
- Devise, Pundit, PaperTrail, ActiveAdmin
- Puma web server
- RSpec for tests

## Architecture overview

- Domain models: `User`, `Team`, `Player`, `League`, `Tournament`, `LeagueTournament`, `Roster`, `RosterPlayer`
- Live data fetchers:
  - `TournamentDataFetcher` fetches tournament status, round, and athlete list from ESPN
  - `TournamentAthleteFetcher` locates athlete rows within the tournament payload
  - `RosterPlayerScoreParser` and `RosterPlayerParser` compute per-player score and status (thru/tee time)
- Caching: tournament payloads cached via `Rails.cache` with short TTL while in-progress, longer when completed
- Frontend: React components mounted via Webpacker, polling `/api/v1/rosters` and `/api/v1/roster_players`

## Routes at a glance

- Root: `/` → `LeaguesController#index`
- Leagues: `/leagues/:id`
- League tournament show: `/leagues/:league_id/tournaments/:id`
- Leaderboards: `/leagues/:league_id/tournaments/:tournament_id/leaderboard`
- Admin: `/admin` (ActiveAdmin)
- API (JSON:API):
  - `/api/v1/rosters?league_tournament_id=:id`
  - `/api/v1/roster_players?league_tournament_id=:id`

## Getting started (development)

### Prerequisites

- Ruby 2.6.6 (rbenv or RVM)
- Node v14.15.4 and Yarn
- PostgreSQL

### Setup

1. Install Ruby gems:

```
bundle install
```

2. Install JavaScript packages:

```
yarn install
```

3. Configure database:

4. Setup and seed the database:

```
bin/rails db:setup
bin/rails db:seed
```

This seeds a couple of `Player` records and, in development, an `AdminUser` with credentials below.

### Run the app

- Start Rails (Webpacker will compile on-demand in development):

```
bin/rails server
```

- Optionally, run the webpack dev server in a separate terminal for faster rebuilds:

```
bin/webpack-dev-server
```

- Visit `http://localhost:3000`

### Admin

- URL: `http://localhost:3000/admin`

### Tests

```
bundle exec rspec
```

## API

Responses follow JSON:API via `jsonapi-rails` serializers.

- Team leaders
  - GET `/api/v1/rosters?league_tournament_id=:id`
  - Attributes per item: `name` (team user name), `score`
- Player leaders
  - GET `/api/v1/roster_players?league_tournament_id=:id`
  - Attributes per item: `name` (golfer), `user_name` (team owner), `score`, `status` (thru/tee time/cut)

## Notes and caveats

- External data is fetched from ESPN (`TournamentDataFetcher`). The API key is currently hard-coded in code for development/demo purposes. In production, move this key to environment configuration and use HTTPS with timeouts and error handling.
- Some dependencies and configurations are pinned to older versions (Rails 5.x, Webpacker, Node 14). See `TODO.md` for suggested upgrades and fixes.

## License

Not specified. Add a license file if you plan to open source this project.
