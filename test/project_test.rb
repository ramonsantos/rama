# frozen_string_literal: true

require_relative 'support/test_helper'
require 'rama/project'

describe Rama::Project do
  subject { Rama::Project.new(temp_dir) }

  let(:temp_dir) { 'my_project' }

  let(:expected_gemfile_content) do
    <<~GEMFILE
      # frozen_string_literal: true

      source 'https://rubygems.org'

      gem 'minitest'
    GEMFILE
  end

  let(:expected_module_content) do
    <<~MODULE
      # frozen_string_literal: true

      module MyProject
        class << self
          def main
            :ok
          end
        end
      end
    MODULE
  end

  let(:expected_test_content) do
    <<~CONTENT
      # frozen_string_literal: true

      require 'minitest/autorun'
      require 'my_project'

      class MyProjectTest < Minitest::Test
        def test_main
          assert_equal(MyProject.main, :ok)
        end
      end
    CONTENT
  end

  let(:expected_rakefile_content) do
    <<~CONTENT
      # frozen_string_literal: true

      require 'rake/testtask'

      Rake::TestTask.new do |t|
        t.libs.push('lib')
        t.verbose = true
        t.test_files = FileList['test/*_test.rb']
      end
    CONTENT
  end

  let(:expected_readem_content) do
    <<~CONTENT
      # my_project

      ## Getting Started

      ### Install Dependencies

      ``` bash
      bundle install
      ```

      ### Run Tests

      ``` bash
      rake test
      ```
    CONTENT
  end

  after { FileUtils.rm_rf(temp_dir) }

  describe '#create' do
    it do
      expect { subject.create }.must_output(/Creating project my_project/)

      expect(Dir.exist?('my_project/')).must_equal(true)
      expect(Dir.exist?('my_project/lib')).must_equal(true)
      expect(Dir.exist?('my_project/test')).must_equal(true)
      expect(Dir.exist?('my_project/lib/my_project')).must_equal(true)
      expect(File.exist?('my_project/Gemfile')).must_equal(true)
      expect(File.exist?('my_project/Rakefile')).must_equal(true)
      expect(File.exist?('my_project/README.md')).must_equal(true)
      expect(File.exist?('my_project/.gitignore')).must_equal(true)
      expect(File.exist?('my_project/lib/my_project.rb')).must_equal(true)
      expect(File.exist?('my_project/test/my_project_test.rb')).must_equal(true)

      expect(File.read('my_project/Gemfile')).must_equal(expected_gemfile_content)
      expect(File.read('my_project/Rakefile')).must_equal(expected_rakefile_content)
      expect(File.read('my_project/lib/my_project.rb')).must_equal(expected_module_content)
      expect(File.read('my_project/test/my_project_test.rb')).must_equal(expected_test_content)
      expect(File.read('my_project/README.md')).must_equal(expected_readem_content)
    end
  end
end
