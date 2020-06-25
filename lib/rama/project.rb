# frozen_string_literal: true

module Rama
  class Project
    def initialize(name, options = [])
      @name      = name
      @options   = options
      @directory = "#{Dir.getwd}/#{name}"
    end

    def create
      puts "Creating project #{@name}"
      create_basic_files
    end

    private

    def create_basic_files
      create_project_directory
      create_lib_directory
      create_sources_directory
      create_test_directory
      create_gemfile_file
      create_rakefile_file
      create_gitignore_file
      create_module_file
      create_test_file
      create_readme_file
    end

    def create_project_directory
      FileUtils.mkdir_p(@directory)
    end

    def create_lib_directory
      FileUtils.mkdir_p("#{@directory}/lib")
    end

    def create_test_directory
      FileUtils.mkdir_p("#{@directory}/test")
    end

    def create_sources_directory
      FileUtils.mkdir_p("#{@directory}/lib/#{@name}")
    end

    def create_gemfile_file
      File.write("#{@directory}/Gemfile", gemfile_content)
    end

    def gemfile_content
      <<~CONTENT
        # frozen_string_literal: true

        source 'https://rubygems.org'

        gem 'minitest'
      CONTENT
    end

    def create_rakefile_file
      File.write("#{@directory}/Rakefile", rakefile_content)
    end

    def rakefile_content
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

    def create_gitignore_file
      resource_path = File.expand_path('../../resource', __dir__)
      FileUtils.cp("#{resource_path}/_.gitignore", "#{@directory}/.gitignore")
    end

    def create_module_file
      File.write("#{@directory}/lib/#{@name}.rb", module_file_content)
    end

    def module_file_content
      <<~CONTENT
        # frozen_string_literal: true

        module #{module_name}
          class << self
            def main
              :ok
            end
          end
        end
      CONTENT
    end

    def create_test_file
      File.write("#{@directory}/test/#{@name}_test.rb", test_file_content)
    end

    def test_file_content
      <<~CONTENT
        # frozen_string_literal: true

        require 'minitest/autorun'
        require '#{@name}'

        class #{module_name}Test < Minitest::Test
          def test_main
            assert_equal(#{module_name}.main, :ok)
          end
        end
      CONTENT
    end

    def create_readme_file
      File.write("#{@directory}/README.md", readme_file_content)
    end

    def readme_file_content
      <<~CONTENT
        # #{@name}

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

    def module_name
      @module_name ||= @name.downcase.split('_').map!(&:capitalize).join
    end
  end
end
