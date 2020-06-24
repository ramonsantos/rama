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
      create_gemfile_file
      create_gitignore_file
      create_module_file
    end

    def create_project_directory
      FileUtils.mkdir_p(@directory)
    end

    def create_lib_directory
      FileUtils.mkdir_p("#{@directory}/lib")
    end

    def create_sources_directory
      FileUtils.mkdir_p("#{@directory}/lib/#{@name}")
    end

    def create_gemfile_file
      File.write("#{@directory}/Gemfile", gemfile_content)
    end

    def gemfile_content
      "# frozen_string_literal: true\n\n" \
      "source 'https://rubygems.org'\n"
    end

    def create_gitignore_file
      resource_path = File.expand_path('../../resource', __dir__)
      FileUtils.cp("#{resource_path}/_.gitignore", "#{@directory}/.gitignore")
    end

    def create_module_file
      File.write("#{@directory}/lib/#{@name}.rb", module_file_content)
    end

    def module_file_content
      "# frozen_string_literal: true\n\n" \
      "module #{module_name}\n" \
      "end\n"
    end

    def module_name
      @name.downcase.split('_').map!(&:capitalize).join
    end
  end
end
