# Required

This gem adds the method required!(val) to main object as well as val.required!. See usage.

## Installation

Add this line to your application's Gemfile:

    gem 'required'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install required

## Usage

```ruby
expect("moo".required!).to_not raise_error
expect("".required!).to raise_error
expect(nil.required!).to raise_error
expect(required! "moo").to_not raise_error
expect(required! nil).to raise_error
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request