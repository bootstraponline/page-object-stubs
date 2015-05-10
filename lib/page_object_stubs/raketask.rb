module PageObjectStubs
  class << self

    # Adds stubs task to Rake
    #
    # @param [Hash] opts
    # @option opts [String] :task_name the name of the stubs task (optional)
    # @option opts [String] :task_desc the description of the stubs task (optional)
    # @option opts [lambda] :targets lambda that will return an array of targets (optional)
    # @option opts [lambda] :targets lambda that will return the output folder (optional)
    # @option opts [Boolean] :angularjs generate angularjs stubs. default true (optional)
    def add_stubs_task opts={}
      task_name     = opts.fetch(:task_name, 'stubs')
      task_desc     = opts.fetch(:task_desc, 'Generate stubs')

      # Get the dir that contains the Rakefile via Rake (__dir__ will not work)
      targets       = opts.fetch(:targets, lambda { Dir.glob(File.join(Rake.application.original_dir, 'page', '*_page.rb')) })
      output_folder = opts.fetch(:output_folder, lambda { File.join(Rake.application.original_dir, 'helper', 'stub') })
      angularjs     = opts.fetch(:angularjs, true)

      raise 'targets must be a lambda' unless targets.lambda?
      raise 'output_folder must be a lambda' unless output_folder.lambda?

      Rake.application.last_description = task_desc
      Rake::Task.define_task task_name do |task|
        PageObjectStubs.generate targets:       targets.call,
                                 output_folder: output_folder.call,
                                 angularjs:     angularjs
      end
    end
  end
end if defined?(Rake::Task)
