source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
# ruby 3.3.1
gem "rails", "~> 7.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"

# Authentication ### aqui me deu problema daí troquei pelo Devise token auth ##
# gem "jwt", "~> 2.9"

# encriptando o token auth
gem "bcrypt", "~> 3.1.7"

# gem devise
# Auth
gem "devise_token_auth"

# Build JSON APIs
gem "jbuilder"

# Time zone support
gem "tzinfo-data", platforms: %i[ windows jruby ]
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

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

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
