# Required!

This gem adds the method #required! to Object, raises an error if nil or String that doesn't match /\S/, otherwise returns self.

## Installation

Add this line to your application's Gemfile:

    gem 'val_required'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install val_required

## Usage

```ruby
expect(ValRequired.set?(nil)).to be_false
expect(ValRequired.set?("")).to be_false
expect(ValRequired.set?(" ")).to be_false
# Otherwise true

expect("token".required!).to_not raise_error

expect("".required!).to raise_error
expect(nil.required!).to raise_error

# The return value for each method on c is checked against ValRequired.set?
expect do
  required(config)! do |c|
    c.api_service_token = "TOKEN"
  end
end.to_not raise_error
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
