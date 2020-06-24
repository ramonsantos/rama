# frozen_string_literal: true

module Rama
  class Project
    def initialize(name, options = [])
      @name = name
      @options = options
    end

    def create
      puts "Creating project #{@name}"
    end
  end
end
