require_relative 'spec_helper'

describe 'page object stubs' do

  # when true, will record new stubs to expected_stub/
  # always set to false before committing (so Travis CI tests against real data)
  def record
    false
  end

  def test_generate opts={}
    page_dir          = join(__dir__, 'page')
    actual_stub_dir   = join(__dir__, 'actual_stub')
    expected_stub_dir = join(__dir__, 'expected_stub')

    targets = glob(join(page_dir, '*_page.rb'))
    output  = actual_stub_dir

    PageObjectStubs.generate targets: targets,
                             output: output,
                             exclude: /#{Regexp.escape('base_page.rb')}/

    actual_stub = read join(actual_stub_dir, 'angular_page_stub.rb')

    test_name     = RSpec.current_example.description.gsub(/\s+/, '_') + '.rb'
    expected_stub = join(expected_stub_dir, test_name)

    open(expected_stub, 'w') { |f| f.write actual_stub } if record

    expected_stub = read expected_stub

    expect(actual_stub).to eq(expected_stub)

    # ensure base_page is excluded properly
    expect(File.exist?(join(actual_stub_dir, 'base_page_stub.rb'))).to eq(false)
  end

  it 'generates stubs correctly' do
    test_generate
  end

  it 'adds rake task without erroring' do
    PageObjectStubs.add_stubs_task
  end
end
