describe 'page object stubs' do
  it 'generates stubs correctly without angularjs support' do
    targets = Dir.glob(File.join(__dir__, 'page', '*_page.rb'))
    output = File.join(__dir__, 'stub')
    PageObjectStubs.generate targets: targets, output: output, angularjs: false

    puts File.read File.join(__dir__, 'stub', 'angular_page_stub.rb')
  end

  # it 'generates stubs correctly with angularjs support' do
  # end
end
