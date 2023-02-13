require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Instaclone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # タイムゾーンの設定
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    
    # ヘルパーなどを追加しないようにする設定
    config.generators do |g|
      g.assets false          # CSS, JavaScriptファイル生成せず
      g.helper false          # Helperファイルを生成せず
      g.skip_routes false     # trueならroutes.rb変更せず、falseなら通常通り変更
      g.test_framework false  # testファイル生成せず
    end 

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
