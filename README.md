# Rama

[![Gem Version](https://badge.fury.io/rb/rama.svg)](https://badge.fury.io/rb/rama)
![ruby](https://img.shields.io/badge/ruby-4.0.0-dc143c)

Rama is a simple Ruby project generator that helps you quickly scaffold new Ruby projects with a basic structure, including tests and configuration files.

## Features

- Generates a complete Ruby project structure
- Includes Minitest for testing
- Creates Gemfile, Rakefile, and .gitignore
- Generates a basic module and test file
- Supports custom project names

## Installation

Install Rama as a gem:

```bash
gem install rama
```

## Usage

To create a new Ruby project, run:

```bash
rama init PROJECT_NAME
```

This will create a new directory called `PROJECT_NAME` with the following structure:

```
PROJECT_NAME/
├── Gemfile
├── Rakefile
├── README.md
├── lib/
│   ├── PROJECT_NAME.rb
│   └── PROJECT_NAME/
├── test/
│   └── PROJECT_NAME_test.rb
└── .gitignore
```

### Example

```bash
$ rama init my_project
Creating project my_project
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ramonsantos/rama.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

