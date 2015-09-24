# PageObjectStubs
[![Gem Version](https://badge.fury.io/rb/page_object_stubs.svg)](https://rubygems.org/gems/page_object_stubs)
[![Dependency Status](https://gemnasium.com/bootstraponline/page_object_stubs.svg?nocache)](https://gemnasium.com/bootstraponline/page_object_stubs)
[![Build Status](https://travis-ci.org/bootstraponline/page_object_stubs.svg?branch=master)](https://travis-ci.org/bootstraponline/page_object_stubs/builds)
[![Coverage Status](https://coveralls.io/repos/bootstraponline/page_object_stubs/badge.svg?nocach)](https://coveralls.io/r/bootstraponline/page_object_stubs)

[PageObject](https://github.com/cheezy/page-object) stub generator for RubyMine.

```ruby
targets       = Dir.glob(File.join(__dir__, '..', 'page', '*_page.rb'))
output_folder = File.join(__dir__, '..', 'stub')
PageObjectStubs.generate targets: targets, output_folder: output_folder, angularjs: false
```

```ruby
# Creates stubs from target Ruby files in output folder with the format
# target_filename_stub.rb
#
# Note the output folder is **DELETED** each time stubs are generated.
#
# ```ruby
# targets = Dir.glob(File.join(__dir__, '..', 'page', '*_page.rb'))
# output = File.join(__dir__, '..', 'stub')
# PageObjectStubs.generate targets: targets, output: output
# ```
#
# @param [Hash] opts
# @option opts [Array<File>] :targets Array of target files to create stubs from (required)
# @option opts [Dir] :output_folder Folder to create stubs in (required)
```

## Contributing

1. Fork it ( https://github.com/bootstraponline/page_object_stubs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
