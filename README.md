# CSS Modules for Rails

[![Build Status](https://travis-ci.org/tomasc/cssm-rails.svg)](https://travis-ci.org/tomasc/cssm-rails) [![Gem Version](https://badge.fury.io/rb/cssm-rails.svg)](http://badge.fury.io/rb/cssm-rails)

A Rails (Sprockets) wrapped on CSS Modules (respective the [CSS Module Loader Core](https://github.com/css-modules/css-modules-loader-core)).
It is a minimal and straightforward implementation at the moment (for example calling `node` command directly via command-line). Pull requests are more than welcome!!!

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

## Requirements

This gem requires Node to be installed.

## Usage

The default CSS modules plugins are `postcss-modules-extract-imports`, `postcss-modules-scope`, `postcss-modules-values`. All CSS is global by default, so that the CSS Modules won't affect the current CSS.
A good idea might be to later implement new extensions (`.css.m`, `.sass.m`, `.scss.m` for example) whose content would be local by default.

```css
.default { /* this class will stay untouched */ };
```

```css
/* common.css */
:local(.bg) { /* this class will be transformed to `.common_bg_HASH` */ };
```

```css
/* event.css */
:local(.title) {
  composes: bg from './common.css';
  /* this class will be transformed to `.event_title_HASH`,
  the outcome of the `cssm` helper will then be `event_title_HASH common_bg_HASH`
  */
}
```

### Helpers

The `cssm` helper outputs css module classes:

```ruby
cssm(file_name, class_name)
```

For example:

```ruby
cssm('event', 'title') # => 'event_title_HASH common_bg_HASH'
```

The `cssms` outputs class selector:

```ruby
cssms('event', 'title') # => '.event_title_HASH.common_bg_HASH'
```

These are helpful to generate module classes in views:

```ruby
<p class="<%= cssm 'event', 'title' %>"> # => <p class="event_title_HASH common_bg_HASH">
  event title
</p>
```

And selectors in JS:

```js
$("<%= cssms 'event', 'title' %>"); // => $('.event_title_HASH.common_bg_HASH')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Rebuilding CSS Modules JS

```sh
bundle exec rake vendor_build
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/css-modules/cssm-rails.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
