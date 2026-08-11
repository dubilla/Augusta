# Be sure to restart your server when you modify this file.
#
# This file contains legacy 5.0-era framework opt-outs. `config.load_defaults 7.1`
# is set in config/application.rb, so the lines still present here are ACTIVE opt-outs
# that override the 7.1 defaults.
#
# NOTE (Stage 6): the `ActiveSupport.to_time_preserves_timezone = false` opt-out was
# removed — it emitted a "removed in Rails 7.2" deprecation under 7.1, and `:zone` (the
# load_defaults 7.1 value) is the correct modern behavior.
#
# The three opt-outs below are intentionally LEFT for a dedicated follow-up PR, not this
# version bump: flipping them changes CSRF handling and adds `belongs_to` presence
# validation. Every FK column is NULLABLE, so belongs_to-required is a real behavioral
# change that needs a data + create-path audit first.

# Enable per-form CSRF tokens. Previous versions had false.
Rails.application.config.action_controller.per_form_csrf_tokens = false

# Enable origin-checking CSRF mitigation. Previous versions had false.
Rails.application.config.action_controller.forgery_protection_origin_check = false

# Require `belongs_to` associations by default. Previous versions had false.
Rails.application.config.active_record.belongs_to_required_by_default = false
