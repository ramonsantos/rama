# frozen_string_literal: true

require 'rama/project'

module Rama
  class Command
    attr_reader :args

    def initialize(args)
      @args = args
    end

    def execute
      do_execute
    rescue StandardError
      abort('Please use --help option for more usage information')
    end

    private

    def do_execute
      if init?
        create_project
      elsif show_help?
        help
      else
        raise StandardError
      end
    end

    def init?
      args.count > 1 && args[0] == 'init'
    end

    def create_project
      _, name, *options = args

      Rama::Project.new(name, options).create
    end

    def show_help?
      args.empty? || help?
    end

    def help?
      args.count == 1 && ['-h', '--help'].include?(args[0])
    end

    def help
      puts 'Usage: rama init PROJECT_NAME'
    end
  end
end
