module PageObjectStubs
  class << self
    # Creates stubs from target Ruby files in output folder with the format
    # target_filename_stub.rb
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
    def generate opts={}
      targets = opts.fetch(:targets)
      targets = targets.select do |target|
        File.file?(target) && File.readable?(target)
      end

      output_folder = File.expand_path(opts.fetch(:output_folder))
      FileUtils.mkdir_p output_folder

      targets.each do |f|
        ast          = Parser::CurrentRuby.parse File.read f
        page_objects = ProcessPageObjects.new

        page_objects.process ast

        file_name        = File.basename(f, '.*')
        file_module_name = file_name.split('_').map(&:capitalize).join
        file_method_name = file_name.downcase
        output_prefix    = <<R
module Stub
  module #{file_module_name}
    class << self
R
        output = ''

        def wrap method_name
          ' ' * 6 + "def #{method_name}; fail('stub called!'); end" + "\n"
        end

        page_objects.name_type_pairs.each do |pair|
          element_type = pair.first
          # if 'page_url' exists, then we need `def goto`
          # for all others, we need the name of the element to generate the remaining methods.
          if element_type == 'page_url'
            output += wrap 'goto'
            next
          end

          element_name = pair.last

          output += wrap "#{element_name}"
          output += wrap "#{element_name}_element"
          output += wrap "#{element_name}?"

          output += wrap "#{element_name}=" if element_type == 'text_field'
        end


        stub_file      = File.join(output_folder, file_name + '_stub.rb')

        # Note that the page method is defined as a singleton method on the
        # top level 'main' object. This ensures we're not polluting the global
        # object space by defining methods on every object which would happen
        # if Kernel was used instead.

        output_postfix = <<R
    end
  end
end

public

def #{file_method_name}
  Stub::#{file_module_name}
end
R

        output = output_prefix + output + output_postfix

        File.open(stub_file, 'w') do |file|
          file.write output
        end
      end
    end
  end
end
