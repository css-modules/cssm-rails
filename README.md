# CSS Modules for Rails

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

Put foo.cssm in your app/assets/stylesheets directory with `.bar { color: red; }`. Use `<div class="<%= cssm "foo:bar" %>">` in your views. `//= require cssm` in then `CSSM.foo.bar` to use from javascript.

## TODO

* Upgrade to ExecJS 2.7 – needs to be patched to run async code
* test pre-process sass, scss, css via Sprockets
* add view helper `cssm "event:title"` (the view helper should be then used via erb in JS)
* add configuration that can be environment specific (format of the generated class name)
* test performance in production (add cache?)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/css-modules/cssm-rails.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
