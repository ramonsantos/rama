# frozen_string_literal: true

require './test/test_helper'
require 'minitest/autorun'
require 'rama/project'

class ProjectTest < Minitest::Test
  def setup
    @temp_dir = 'my_project'
  end

  def teardown
    FileUtils.rm_rf(@temp_dir)
  end

  def test_create_project
    project = Rama::Project.new('my_project')

    assert_output(/Creating project my_project/) { project.create }

    assert(Dir.exist?('my_project/'))
    assert(Dir.exist?('my_project/lib'))
    assert(Dir.exist?('my_project/test'))
    assert(Dir.exist?('my_project/lib/my_project'))
    assert(File.exist?('my_project/Gemfile'))
    assert(File.exist?('my_project/Rakefile'))

    assert(File.exist?('my_project/.gitignore'))
    assert(File.exist?('my_project/lib/my_project.rb'))
    assert(File.exist?('my_project/test/my_project_test.rb'))

    assert_equal(File.read('my_project/Gemfile'), expected_gemfile_content)
    assert_equal(File.read('my_project/Rakefile'), expected_rakefile_content)
    assert_equal(File.read('my_project/lib/my_project.rb'), expected_module_content)
    assert_equal(File.read('my_project/test/my_project_test.rb'), expected_test_content)
  end

  def expected_gemfile_content
    <<~GEMFILE
      # frozen_string_literal: true

      source 'https://rubygems.org'

      gem 'minitest'
    GEMFILE
  end

  def expected_module_content
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

  def expected_test_content
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

  def expected_rakefile_content
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
end
