source "https://rubygems.org"
# ruby 3.3.6 (2024-11-05 revision)
gem "rails", "~> 8.0.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"

# Authentication
gem "jwt", "~> 2.10"
gem "bcrypt", "~> 3.1.7"

# Build JSON APIs
gem "jbuilder"

# Time zone support
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Cache e Jobs
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduzir tempos de inicialização
gem "bootsnap", require: false

# Deploy com Docker
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "byebug", platforms: [ :mri, :mingw, :x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "shoulda-matchers"
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Estilo de código
  gem "rubocop-rails-omakase", require: false
end
