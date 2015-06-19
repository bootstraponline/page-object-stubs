# gems
require 'rubygems'
require 'rake'
require 'coveralls'
Coveralls.wear!

require 'rspec'
require 'pry'

# ruby core
require 'fileutils'
require 'forwardable'

# lib
require_relative '../lib/page_object_stubs'

# use the file helpers I wrote for appium.io
# https://github.com/appium/appium.io/blob/a6396a9c04ae8d4b2d9b12fd62ce519febefa976/rake_lib/files.rb
module PageObjectStubs
  extend Forwardable

  # Avoid having to type 'File.' to use these common methods
  def_delegators File, :exist?, :exists?, :basename, :expand_path, :dirname,
                 :directory?, :read
  def_delegators FileUtils, :mkdir_p, :rm_rf
  def_delegators Dir, :glob

  # Join the paths then expand the path
  # Paths that are joined and not expanded cause problems
  def join *args
    File.expand_path File.join(*args)
  end
end

RSpec.configure do |config|
  config.include PageObjectStubs
end
