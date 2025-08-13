# TODO

A prioritized list of fixes, upgrades, and enhancements discovered while reviewing the codebase.

## High-impact fixes (bugs and correctness)

- React list keys: in `app/javascript/src/leaderboard/*Leaders.jsx`, replace `key="{leader.id}"` with `key={leader.id}`.
- Tournament scopes: `Tournament.incomplete` currently uses `-> { !completed }`. Replace with `-> { where(completed: false) }` or remove if redundant with `active`.
- Tournaments sorting in view: `@league.league_tournaments.sort_by{|t| !t.start_date}` is incorrect. Sort by date explicitly (e.g., `order(start_date: :desc)` or `sort_by(&:start_date)`).
- Roster score safety: `Roster#score` uses `reduce(:+)` which returns nil when the collection is empty. Use `sum` or `reduce(0, :+)`.
- ActiveAdmin tournaments form: in `app/admin/tournaments.rb`, use `f.input` (not `input`) inside the `form do |f|` block.
- HTTP and JSON parsing: `TournamentDataFetcher` uses `http://` and `Hash[HTTParty.get(url)]`. Use HTTPS and parse the body safely (e.g., `HTTParty.get(url).parsed_response`) with error handling and timeouts.
- React intervals: `useEffect` that sets an interval should return a cleanup function to clear it on unmount.
- Add DB indexes for foreign keys: `rosters.team_id`, `rosters.league_tournament_id`, `roster_players.roster_id`, `roster_players.player_id`, `teams.user_id`, `teams.league_id`, etc.

## Security and configuration

- Move the ESPN API key out of source code into environment configuration (Rails credentials or dotenv). Read via `ENV['ESPN_API_KEY']`.
- Use HTTPS endpoints and set reasonable HTTP timeouts/retries. Guard against nils and schema changes from the upstream API.
- Remove or replace `rails_12factor` (not needed on modern Rails/Heroku). Configure logging and static assets via built-in Rails mechanisms.
- Add Content Security Policy adjustments for React endpoints if needed (`config/initializers/content_security_policy.rb`).

## Upgrades and modernizations

- Ruby: upgrade from 2.6.6 → 3.2/3.3.
- Rails: upgrade from 5.x → 6.1/7.1 (zeitwerk, credentials, improved ActiveRecord).
- JavaScript bundling: migrate from Webpacker → jsbundling-rails (esbuild) or Vite. Remove `rails-ujs`/jQuery if not needed.
- Node: upgrade Node 14 → 18/20 LTS; update dependencies accordingly.
- Tailwind: move from PostCSS7 compat to Tailwind 3.x with postcss 8+.
- Test stack: replace `factory_girl(_rails)` with `factory_bot(_rails)`; replace `poltergeist` (PhantomJS) with headless Chrome via `capybara` + `selenium-webdriver` or `cuprite`.
- CI: retire TravisCI config and add a GitHub Actions workflow (Ruby, Node, Postgres services).

## Observability and performance

- Replace ad-hoc caching with an explicit caching layer and invalidation strategy. Consider background jobs (Sidekiq) to refresh tournament data on a schedule instead of polling on request.
- Add application monitoring (New Relic is present; verify it's configured) and error tracking (Sentry/Honeybadger).
- Add `includes`/`preload` where necessary to avoid N+1 queries (most leader pages look fine, but audit others).

## Product and UX

- Add UI flows to create/edit Leagues, Teams, Rosters (currently mostly admin/seed driven).
- Display historical tournaments and results with clearer sorting and filtering.
- Improve responsive layout and accessibility (ARIA, color contrast). Tailwind makes this straightforward.
- Add authentication flows for users (sign-up/sign-in are present via Devise, but harden validations and UX).

## Developer experience

- Add `.ruby-version` (2.6.6) and `.tool-versions` (asdf) or update to the modern versions when upgrading.
- Add `.env.example` documenting expected env vars (DB credentials, ESPN API key, cache store settings).
- Add RuboCop configuration and run it in CI; consider `rails_best_practices` removal in favor of cops.
- Add seeds for local development (leagues, teams, tournaments, rosters) and a `bin/dev` to run Rails + JS concurrently.

## Nice-to-haves

- Replace direct ESPN calls with a service object that caches and normalizes data shape; add VCR-backed tests.
- Consider using `jsonapi-serializer` or `fast_jsonapi` for performance and maintenance.
- Add a public read-only API key or rate limiting if exposing endpoints publicly.