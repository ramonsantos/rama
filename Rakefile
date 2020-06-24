# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

task default: :spec

Rake::TestTask.new do |t|
  t.libs.push('lib')
  t.verbose = true
  t.test_files = FileList['test/*_test.rb']
end
