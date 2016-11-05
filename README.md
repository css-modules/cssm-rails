# CSS Modules for Rails

[![Build Status](https://travis-ci.org/tomasc/cssm-rails.svg)](https://travis-ci.org/tomasc/cssm-rails) [![Gem Version](https://badge.fury.io/rb/cssm-rails.svg)](http://badge.fury.io/rb/cssm-rails)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cssm-rails'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install cssm-rails
```

## Usage

### Stylesheets

```css
```

### Javascript

```js
// my.js.erb

$(".<%= cssm("foo:bar") %>")
```

### Views

```erb
<p class='<%= cssm "foo:bar" %>'>paragraph</p>
```

## TODO

* Upgrade to ExecJS 2.7 – needs to be patched to run async code
* add `pathFetcher` to allow `compose` across files
* test pre-process sass, scss, css via Sprockets (or .sass.m, .scss.m, .css.m ?)
* add configuration that can be environment specific (format of the generated class name)
* test performance in production (add cache?)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/css-modules/cssm-rails.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
