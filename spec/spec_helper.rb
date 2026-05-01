$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'caml'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |file| require file }

module FixtureHelpers
  def fixture_path(name)
    File.expand_path("../fixtures/#{name}", __FILE__)
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FixtureHelpers
end
