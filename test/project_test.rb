# frozen_string_literal: true

require 'minitest/autorun'
require 'rama/project'

class ProjectTest < Minitest::Test
  def test_create_project
    project = Rama::Project.new('rama')

    assert_output(/Creating project rama/) { project.create }
  end
end
