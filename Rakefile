require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test

desc 'rebuild the vendored postcss-modules'
task :vendor_build do
  `cd vendor/src && npm install`
  `cd vendor/src && npm run bundle`

  # re-enable the fs module (which would be removed by browserify if uncommented)
  bundle = File.join(__dir__, 'vendor/bundle.js')
  content = File.read(bundle).gsub("// var fs = require('fs');", "var fs = require('fs');")
  File.open(bundle, 'w+') do |output_file|
    output_file.write(content)
  end
end
