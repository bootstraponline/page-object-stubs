require 'thor'

class Default < Thor
  desc 'spec', 'Run RSpec tests'
  def spec
    exec 'rspec spec'
  end
end

require 'appium_thor'

Appium::Thor::Config.set do
  gem_name 'page_object_stubs'
  github_owner 'bootstraponline'
end
