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
  `cd vendor_build && npm install`
  `cd vendor_build && npm run bundle`
end
