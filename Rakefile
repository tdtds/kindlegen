require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

# add build task as prerequisite task; tests depend on built gem
Rake::Task[:test].enhance [:build]

task :default => :build
