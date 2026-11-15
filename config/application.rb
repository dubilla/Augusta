require_relative 'boot'

require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Augusta
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # 7.2 turns YJIT on; set DISABLE_YJIT on a memory-tight dyno to opt out without a deploy.
    config.yjit = ENV['DISABLE_YJIT'].blank?

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # rack-proxy >= 1.0 refuses to derive its backend from the request Host
    # header, which Shakapacker's DevServerProxy relies on, so every /packs
    # request proxied through `rails s` 502s. Give it an explicit backend.
    initializer 'augusta.dev_server_proxy_backend', after: 'shakapacker.proxy' do |app|
      if (Shakapacker.config.dev_server.present? rescue nil)
        dev_server = Shakapacker.dev_server
        app.middleware.swap Shakapacker::DevServerProxy, Shakapacker::DevServerProxy,
          ssl_verify_none: true,
          backend: "#{dev_server.protocol}://#{dev_server.host_with_port}"
      end
    end
  end
end
