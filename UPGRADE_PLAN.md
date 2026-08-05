# Ruby & Rails Upgrade Plan — Augusta

**Goal:** Ruby 2.6.6 → **3.3.12**, Rails 5.2.4.4 → **7.1**, deployable on Heroku.
**Deployable checkpoint:** Rails 6.1 / Ruby 3.1 (Stage 4) — first green Heroku deploy.
**Final:** Rails 7.1 / Ruby 3.3.12 (Stage 7).

---

## Why this is a Rails upgrade, not a Ruby bump

- Rails 5.2 **cannot run on any Ruby 3.x** (3.0 changed keyword args + removed internals 5.2 relies on). 5.2's practical ceiling is Ruby 2.7.
- Per Heroku's [Ruby support reference](https://devcenter.heroku.com/articles/ruby-support-reference), **every current stack (Heroku‑22/‑24/‑26) requires Ruby ≥ 3.1.0.** Ruby 2.7 no longer deploys on Heroku at all — so there is no "small" version of this.
- Ruby **3.3.12 is Heroku's current listed supported version** — a good end target. Reaching it requires **Rails ≥ 7.0.8 (we target 7.1).**

**Discipline: never bump Ruby and Rails in the same stage.** Change one variable, get the suite green, commit, then move on. This is why Ruby and Rails bumps are interleaved as separate stages below.

---

## Current state (facts from this repo)

| Area | Now |
|------|-----|
| Ruby | 2.6.6 (no `.ruby-version` file — version only in `Gemfile`) |
| Rails | 5.2.4.4, `config.load_defaults 5.1` |
| DB | `pg` 0.21.0 (Rails 6 needs ≥ 1.1) |
| Admin | ActiveAdmin 2.0.0 (+ ransack 2.1, formtastic 3.1, arbre 1.2, kaminari 1.2, draper via AA) |
| Frontend | webpacker 5.2.1, React 17, Tailwind 2, custom `config/webpack` |
| Tests | RSpec 3.8, Capybara 3.21, **poltergeist 1.18** (dead — PhantomJS), **factory_girl** |
| Deploy | Heroku, Puma, `rails_12factor` 0.0.3 (obsolete) |
| App size | 28 models, 8 controllers, 6 ActiveAdmin resources, 10 spec files |

### Code scan results (what actually breaks)
- ✅ **No Ruby-3 string breakers** — no `URI.escape/encode`, `File.exists?`, `BigDecimal.new`, `taint`, or `open(url)`. The app code is largely Ruby-3-safe.
- ✅ No `before_filter`/`after_filter`, no `render text:`/`render nothing:`.
- ⚠️ `update_attributes` — **4 occurrences** → rename to `update` (removed in Rails 6.1).
- ⚠️ `factory_girl` / `FactoryGirl` — **3 occurrences** → rename to `factory_bot` / `FactoryBot`.
- ⚠️ **Zero `ransackable_attributes`/`ransackable_associations` definitions** — Ransack 4 (required for Rails 7) raises unless models allowlist searchable fields. All AA-filtered models need this at Stage 5.
- ✅ Zeitwerk risk is **low**: no custom `autoload_paths`; `app/policies` and `app/serializers` are name-compliant; `app/admin` is registered by ActiveAdmin (not Zeitwerk-autoloaded).

---

## Gem / dependency replacement map

| Gem | Now | Rails 6.x target | Rails 7.1 target | Notes |
|-----|-----|------------------|------------------|-------|
| rails | 5.2.4.4 | 6.0.6.1 → 6.1.7.10 | ~> 7.1.5 | staged |
| pg | 0.21.0 | ~> 1.5 | ~> 1.5 | **hard blocker** for Rails 6 |
| activeadmin | 2.0.0 | ~> 2.14 | ~> 3.2 | tightest constraint; AA 3.x needs Rails ≥ 6.1 |
| ransack | 2.1.1 | ~> 2.6 | ~> 4.2 | **4.0 requires allowlists** (see scan) |
| formtastic | 3.1.5 | ~> 4.0 | ~> 5.0 | AA dependency |
| arbre | 1.2.1 | ~> 1.5 | ~> 1.7 | AA dependency |
| kaminari | 1.2.1 | ~> 1.2.2 | ~> 1.2.2 | minor |
| devise | 4.6.2 | ~> 4.8 | ~> 4.9 | |
| pundit | 2.0.1 | ~> 2.3 | ~> 2.3 | |
| paper_trail | 10.3.0 | ~> 12.3 | ~> 15.1 | version tied to Rails |
| puma | 5.1.0 | ~> 5.6 | ~> 6.4 | |
| nokogiri | 1.13.10 | ~> 1.16 | ~> 1.18 | Ruby 3.3 needs ≥ 1.16 |
| bootsnap | 1.4.4 | ~> 1.18 | ~> 1.18 | |
| webpacker | 5.2.1 | keep 5.x | **→ shakapacker ~> 8** | webpacker retired in Rails 7; shakapacker is the drop-in fork (keeps React/Tailwind/custom webpack config) |
| sass (ruby) | 3.7.4 | **remove** | **remove** | EOL; use sassc-rails for sprockets side |
| sass-rails | (impl) | → sassc-rails ~> 2.1 | sassc-rails ~> 2.1 | |
| poltergeist | 1.18.1 | **→ cuprite ~> 0.15** | cuprite | PhantomJS dead; cuprite = closest poltergeist replacement (headless Chrome) |
| factory_girl(_rails) | — | **→ factory_bot(_rails) ~> 6** | ~> 6 | rename in code + factories.rb |
| capybara | 3.21.0 | ~> 3.40 | ~> 3.40 | |
| vcr | 4.0.0 | ~> 6.3 | ~> 6.3 | |
| webmock | 3.5.1 | ~> 3.x | ~> 3.x | |
| rubocop | 0.70.0 | ~> 1.x | ~> 1.x | dev-only, low priority; config churn |
| rails_12factor | 0.0.3 | **remove** | **remove** | obsolete since Rails 5; Heroku handles logs/assets natively |
| newrelic_rpm / dalli / httparty / uglifier | — | latest patch | latest patch | routine bumps |

Also: add a **`.ruby-version`** file (currently missing) and a **`BUNDLED WITH`** to `Gemfile.lock` (currently absent).

---

## Staged plan

Each stage ends at a green suite + commit. Bold stages are Heroku-deployable.

### Stage 0 — Prep (Ruby 2.6 / Rails 5.2)
> **START HERE.** Do not skip to Stage 1 — the baseline-green step below is what makes every later "what did I break?" answerable.
>
> **Local-env blocker (verified 2026-08-03):** nothing on this machine runs 2.6.6. Active Ruby is macOS **system 2.6.10** (`/usr/bin/ruby`); rbenv has only `system` + `3.3.4`; `bundle check` fails ("Ruby 2.6.10 but Gemfile specified 2.6.6"). First action: `rbenv install 2.6.6` + add a `.ruby-version` file (recommended — matches the pin, avoids system Ruby for native gems). Alt: repin Gemfile to `2.6.10`.
> **Expect `pg` 0.21.0 (2017) to fight Apple Silicon** on bundle — getting the baseline to install + boot is real work here, possibly needing a libpq flag or minor pg patch bump.

- Get the existing suite **green on 2.6.6 / 5.2** as the baseline. Fix flaky/broken specs first — you can't tell what an upgrade broke otherwise.
- Add `.ruby-version` (`2.6.6`), pin `BUNDLED WITH`.
- Safe, framework-independent cleanups now (smaller diffs later):
  - `factory_girl` → `factory_bot` (rename gem + `factories.rb` + 3 code refs).
  - Replace **poltergeist → cuprite** in `spec/support` + `rails_helper` driver registration.
  - Remove `rails_12factor`.
  - `update_attributes` → `update` (4×).
- **Gate:** full RSpec green on 2.6.6 / 5.2.

#### ✅ Stage 0 completed (2026-08-03) — outcome & env notes
Gate met: **18 examples, 0 failures, 1 pending** (the pending was the empty `admin_user_spec` stub). Ruby pinned to **2.6.10** (system Ruby; 2.6.6 won't build on this Apple Silicon machine) per decision on 2026-08-03.

**Stage 0.1 (2026-08-03):** filled the `admin_user_spec` stub with 7 Devise-`:validatable` examples (email presence/uniqueness/case-insensitivity/format, password presence + 8-char floor) + added an `admin_user` factory. Suite now **24 examples, 0 failures, 0 pending** — pulls forward cheap-insurance item #3 below.

Cleanups landed as planned, with two env-forced deviations (both in the plan's spirit):
- **`factory_bot` pinned `~> 5.2`, not `~> 6`.** factory_bot 6.x uses Ruby-2.7 argument-forwarding syntax (`...`) → hard `SyntaxError` on Ruby 2.6. The `~> 6` bump belongs to a later Ruby stage (≥ Stage 1). factory_bot 5+ also requires block syntax for static attrs — converted `password { "password" }` / `winner { false }` in `spec/factories.rb`.
- **`ffi` bumped 1.11.1 → 1.16.3** (transitive via sass→sass-listen→rb-inotify). 1.11.1 won't compile against the current clang/Xcode SDK; 1.17+ requires Ruby 3.0, so 1.16.3 is the last 2.6-compatible line.

**Apple-Silicon / local-env gotchas (carry into every later stage + CI + Heroku):**
1. **`pg` 0.21.0** compiles only when pointed at Homebrew `postgresql@16`'s `pg_config`. Set via local `.bundle/config`: `bundle config set --local build.pg "--with-pg-config=/opt/homebrew/opt/postgresql@16/bin/pg_config"`.
2. **`mimemagic 0.3.10`** needs `shared-mime-info` **at build time only**: `brew install shared-mime-info` + `FREEDESKTOP_MIME_TYPES_PATH=/opt/homebrew/share/mime/packages/freedesktop.org.xml`. Not needed at runtime. (Rails 6 upgrade replaces marcel/mimemagic — this pain disappears at Stage 2.)
3. **nokogiri arch mismatch:** the lock can resolve to an `x86_64-darwin` precompiled variant that can't load on arm64 (`cannot load such file -- nokogiri/nokogiri`). Fixed with `bundle config set --local force_ruby_platform true` so native gems compile locally. **Revisit at Stage 7** — for Heroku (linux) you want the precompiled platform gems, so this local-only flag must not leak into the deploy.
4. **Webpack/Node:** `webpacker:compile` fails under Node 24 with `ERR_OSSL_EVP_UNSUPPORTED` (webpack 4 vs Node 17+). Workaround: `NODE_OPTIONS=--openssl-legacy-provider`. The 3 feature specs fail until test packs are compiled. Permanently resolved by the **shakapacker swap at Stage 5**; until then, either export `NODE_OPTIONS` or pin a Node ≤ 16 via a version manager.
5. **Bundler 2.1.4** installs to `/Library/Ruby` (needs sudo) under system Ruby → used project-local `vendor/bundle` (gitignored) instead.

### Stage 1 — Ruby 2.6 → 2.7.8 (Rails 5.2)
- Bump `.ruby-version` + Gemfile to `2.7.8`. Rails 5.2 supports 2.7.
- Resolve 2.7 deprecation warnings (mostly keyword-arg separation warnings — fixing them now de-risks Ruby 3.0's hard break).
- **Gate:** suite green on 2.7.8 / 5.2.

#### ✅ Stage 1 completed (2026-08-04) — outcome & env notes
- **Ruby 2.6.10 → 2.7.8**, Rails held at 5.2.4.4. Suite: **24 examples, 0 failures**. App boots. Branch `stage-1-ruby-2.7.8`.
- **One forced gem bump:** `bootsnap 1.4.4 → 1.4.9` (`~> 1.4.8` pin). bootsnap < 1.4.6 hard-crashes on 2.7 boot (`LoadedFeaturesIndex#register`: `no implicit conversion of String into Integer`). Its dep `msgpack` came along `1.2.10 → 1.8.4` (bootsnap-only, no Rails coupling; `--conservative` wouldn't hold the old one).
- **No app-code 2.7 kwarg-separation warnings.** The only kwarg warnings come from inside `json 2.2.0` (`json/common.rb:156`); the lone Rails deprecation (`secrets.secret_token`) is a **Rails 6.0** removal → Stage 2. Nothing in our code to fix here.
- **⚠️ Native-gem build wall on 2.7.8 + modern Clang (Xcode/Apple Clang, C23 default):** old C exts fail to compile because `-Wincompatible-function-pointer-types` is now a hard **error** (e.g. `rb_rescue`/`rb_rescue2`/`rb_define_singleton_method` pointer-arity mismatches in pg 0.21.0, jaro_winkler 1.5.2, nio4r 2.5.4, bootsnap). Fix is **local-only** (`.bundle/config`, gitignored — must NOT leak to Heroku): a per-gem `build.<gem>` config appending `--with-cflags=-Wno-incompatible-function-pointer-types` for every native gem (pg additionally keeps `--with-pg-config=…`). Env `CFLAGS` does **not** propagate through mkmf — must use the mkmf `--with-cflags` build arg. Bundler 2.1.4 corrupts `.bundle/config` YAML when `bundle config set` rewrites a hyphenated key (`build.websocket-driver`); hand-write that key as `BUNDLE_BUILD__WEBSOCKET-DRIVER` (hyphen preserved, **not** `___`). This whole workaround shrinks as native gems get bumped in later stages (pg→1.5 at Stage 2, etc.).

### Stage 2 — Rails 5.2 → 6.0 (Ruby 2.7)
- `pg` → 1.5, `rails` → 6.0.6.1, AA → 2.14 + its stack (ransack 2.6, formtastic 4, arbre 1.5), devise/pundit/paper_trail/puma/nokogiri per map.
- Run `bin/rails app:update`; carefully merge `config/`. Adds `new_framework_defaults_6_0.rb` (keep new defaults **off** initially).
- **Zeitwerk**: default in 6.0. If autoload errors appear, temporary escape hatch `config.autoloader = :classic`, but aim to run Zeitwerk clean (low risk here). Verify with `bin/rails zeitwerk:check`.
- **Gate:** suite green; boots; `zeitwerk:check` clean. Then flip `load_defaults 6.0` and re-green.

### Stage 3 — Rails 6.0 → 6.1 (Ruby 2.7)
- `rails` → 6.1.7.10, `paper_trail` → 12.3, AA stays 2.14 (supports 6.1).
- `app:update` → merge `new_framework_defaults_6_1.rb`; flip `load_defaults 6.1`.
- Confirm `update_attributes` are gone (removed here).
- **Gate:** suite green on 2.7 / 6.1.

### **Stage 4 — Ruby 2.7 → 3.1 (Rails 6.1) ← FIRST DEPLOYABLE CHECKPOINT**
- Bump `.ruby-version` + Gemfile → `3.1.6`. Rails 6.1 fully supports Ruby 3.1.
- Add `require "csv"`-style stdlib gems if any bundler/default-gem warnings appear (Ruby 3.1+ unbundles some stdlib).
- **Deploy to Heroku here** — this is the minimum that satisfies Heroku's Ruby ≥ 3.1 floor. Ship it, breathe.
- **Gate:** suite green on 3.1 / 6.1 **+ successful Heroku deploy + smoke test.**

### Stage 5 — Rails 6.1 → 7.0 (Ruby 3.1)
Biggest stage — three hard items:
1. **webpacker → shakapacker ~> 7/8.** Rename config, keep `config/webpack` + React/Tailwind. Update `package.json` (`@rails/webpacker` → `shakapacker`).
2. **Ransack 4.2.** Define `ransackable_attributes`/`ransackable_associations` on every model exposed to ActiveAdmin filters (scan found **none defined**). Either per-model allowlists or a shared `ApplicationRecord` override — decide with the data-model owner (security-sensitive: controls what's queryable).
3. **ActiveAdmin → 3.2** (requires Rails ≥ 6.1; formtastic 5, arbre 1.7). Review AA customizations/`arbre` components.
- Zeitwerk is now the **only** autoloader (`:classic` removed) — must run clean.
- `app:update` → `new_framework_defaults_7_0.rb`; flip `load_defaults 7.0`.
- **Gate:** suite green; AA screens + webpack assets verified in a review app.

### Stage 6 — Rails 7.0 → 7.1 (Ruby 3.1)
- `rails` → ~> 7.1.5, `paper_trail` → 15.1, puma → 6.4.
- `app:update` → `new_framework_defaults_7_1.rb`; flip `load_defaults 7.1`.
- Note 7.1 `secret_key_base` / credentials handling — you currently use `secrets.yml` + legacy `secret_token.rb`; confirm secret resolution on Heroku (env `SECRET_KEY_BASE`).
- **Gate:** suite green on 3.1 / 7.1.

### **Stage 7 — Ruby 3.1 → 3.3.12 (Rails 7.1) ← FINAL**
- Bump `.ruby-version` + Gemfile → `3.3.12`. Ensure `nokogiri` ≥ 1.16 and any native gems have 3.3 builds.
- Install 3.3.12 locally first (`rbenv install 3.3.12` — update ruby-build; current local max is 3.3.11).
- **Deploy to Heroku.** Done — current end state.
- **Gate:** suite green on 3.3.12 / 7.1 + Heroku deploy + smoke test.

---

## Test-coverage reality (read before trusting a green build)

The suite is **thin — ~17 examples across 10 files** — which changes what a passing build actually means.

| Surface | Coverage |
|---|---|
| Rake domain logic (`scoring`, `finalizing`) | ✅ 6 examples — the real business logic |
| Models | 5 of 28 specced; `admin_user_spec` is an **empty stub** (0 examples) |
| Features | 3 specs, each a single happy-path "user sees data" page render |
| **ActiveAdmin** | ❌ none |
| **JSON API / serializers** | ❌ none (despite jsonapi-rails + 2 serializers) |
| Controllers / requests / system | ❌ none |
| Auth (devise) | ❌ only implicit via page renders |
| CI | `.travis.yml` only — **Travis is dead**, so there is effectively no running CI |

**What "a build" is worth here (~70%), and why:** because the suite is this thin, most upgrade breakage is **load-time** — gem incompatibilities, Zeitwerk autoload errors, deprecated-API-at-boot, asset/webpack compile failures — which `bundle` + boot + `assets:precompile` + the 17 specs will catch. There aren't enough behavioral tests for subtle regressions to hide behind.

**The 30% it misses is not evenly distributed — it sits on your highest-risk surfaces, and they're all silent:**
- **ActiveAdmin + Ransack 4** — missing allowlists raise at **query time, not boot**. A green build says nothing. This is both the #1 upgrade risk (Stage 5) and the #1 test blind spot.
- **JSON API / serializers** — jsonapi-rails across a major Rails jump, zero coverage.
- **React/webpack pages** — compile ≠ renders correctly after the shakapacker swap.

→ Treat a green build as strong signal on "does it boot and load," and as **no signal at all** on ActiveAdmin, the API, and React. Those need the additions and manual smoke below.

### Cheap insurance to add before Stage 5 (~½ day, high-leverage)
Converts the two biggest blind spots into automated gates:
1. **ActiveAdmin smoke spec** — load each of the 6 admin index + filter pages, assert 200. Directly catches the Ransack-4 allowlist breakage the suite is currently blind to.
2. **One serializer/API request spec** for a representative endpoint.
3. ✅ **Done in Stage 0.1** — filled the empty `admin_user_spec` with 7 Devise-validation examples (was: a 0-example pending stub).

### Manual smoke checklist (run at every deployable stage — 4 & 7)
Because the automated suite can't cover these, run by hand on the review app:
- [ ] Login via devise (real session, not just page render)
- [ ] One ActiveAdmin resource: index **+ apply a filter** (exercises Ransack) + edit/save
- [ ] One JSON API endpoint returns correct serialized payload
- [ ] One React/webpack-bundled page renders and is interactive
- [ ] `scoring` + `finalizing` rake tasks run against realistic data

## Test gates (every stage)
1. `bundle install` clean, app boots (`bin/rails runner 1`).
2. `bin/rails zeitwerk:check` clean (Stages 2+).
3. Full RSpec suite green (models + features via cuprite).
4. Manual smoke checklist above (abbreviated on non-deployable stages: login + one AA filter page).
5. Deployable stages: push to a Heroku **review/staging** app before production.

## Risks & watch-items
- **ActiveAdmin + Ransack 4** is the highest-risk cluster (Stage 5). The missing ransack allowlists are a behavioral + security change — budget the most time here.
- **webpacker → shakapacker** (Stage 5): custom `config/webpack` may need tweaks; verify Tailwind 2 + React 17 build.
- **Heroku-24 native gem compilation** for Ruby 3.3 (nokogiri, pg) — verify on a review app, not production.
- **Thin test suite (~17 examples)** — a green build is ~70% signal but blind to ActiveAdmin, the JSON API, and React. See "Test-coverage reality"; add the smoke specs before Stage 5 and run the manual checklist on Stages 4 & 7.
- Keep each stage a **separate PR** for clean rollback; deploy only from Stages 4 and 7.

## Effort (rough)
- Stage 0–1: ~1–2 days · Stage 2–4 (to first deploy): ~3–5 days · Stage 5: ~3–5 days (AA/ransack/shakapacker) · Stage 6–7: ~2–3 days.
- **Total ≈ 2–3 focused weeks**, front-loaded value: **deployable Heroku app by end of Stage 4.**
