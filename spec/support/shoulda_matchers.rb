# o Shoulda Matchers para nos ajudar a testar alguns recursos dos models;
# Estamos configurando o framework de teste como **RSpec** e a biblioteca de aplicação como sendo o Rails.
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
