# Rack::Capture

[![](https://badge.fury.io/rb/rack-capture.svg)](https://rubygems.org/gems/rack-capture)
[![test](https://github.com/r7kamura/rack-capture/workflows/test/badge.svg)](https://github.com/r7kamura/rack-capture/actions?query=workflow%3Atest)

Generate static files from Rack application and URLs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-capture'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rack-capture

## Usage

Call `Rack::Capture.call` to generate static file.

```ruby
require 'rack/capture'

%w[
  http://example.com/
  http://example.com/articles
  http://example.com/articles/2020-10-30.html
  http://example.com/articles/2020-10-29.html
  http://example.com/articles/2020-10-28.html
  http://example.com/feed.xml
  http://example.com/sitemap.txt
].each do |url|
  Rack::Capture.call(
    app: my_rack_application,
    url: url
  )
end
```

### Arguments

- `:app` - Rack application to be used for rendering response
- `:url` - URL
- `:output_directory_path` - Where to output files (default: `"dist"`)
- `:script_name` - Rack SCRIPT_NAME, commonly used for GitHub Pages project sites (default: `""`)

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Local install

To install this gem onto your local machine, run `bundle exec rake install`.

### Release

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/r7kamura/rack-capture.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
