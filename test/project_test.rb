# frozen_string_literal: true

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
    assert(Dir.exist?('my_project/lib/my_project'))
    assert(File.exist?('my_project/Gemfile'))
    assert(File.exist?('my_project/.gitignore'))
    assert(File.exist?('my_project/lib/my_project.rb'))

    assert_equal(File.read('my_project/Gemfile'), expected_gemfile_content)
    assert_equal(File.read('my_project/lib/my_project.rb'), expected_module_content)
  end

  def expected_gemfile_content
    "# frozen_string_literal: true\n" \
    "\n" \
    "source 'https://rubygems.org'\n"
  end

  def expected_module_content
    "# frozen_string_literal: true\n" \
    "\n" \
    "module MyProject\n" \
    "end\n"
  end
end
