module PageObjectStubs
  class << self

    # Adds stubs task to Rake
    #
    # @param [Hash] opts
    # @option opts [String] :task_name the name of the stubs task (optional)
    # @option opts [String] :task_desc the description of the stubs task (optional)
    # @option opts [lambda] :targets lambda that will return an array of targets (optional)
    # @option opts [lambda] :output lambda that will return the output folder (optional)
    def add_stubs_task opts={}
      task_name = opts.fetch(:task_name, 'stubs')
      task_desc = opts.fetch(:task_desc, 'Generate stubs')

      # Get the dir that contains the Rakefile via Rake (__dir__ will not work)
      targets   = opts.fetch(:targets, lambda { Dir.glob(File.join(Rake.application.original_dir, 'page', '*_page.rb')) })
      output    = opts.fetch(:output, lambda { File.join(Rake.application.original_dir, 'helper', 'stub') })
      exclude   = opts.fetch(:exclude, false)

      raise 'targets must be a lambda' unless targets.lambda?
      raise 'output must be a lambda' unless output.lambda?
      raise 'exclude must be a regex' if exclude && exclude.class != Regexp

      Rake.application.last_description = task_desc
      Rake::Task.define_task task_name do
        PageObjectStubs.generate targets: targets.call,
                                 output:  output.call,
                                 exclude: exclude
      end
    end
  end
end if defined?(Rake::Task)
