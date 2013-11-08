require 'spec_helper'

require 'ostruct'

def does_not_fail val
  expect { required! val }.to_not raise_error
  expect { val.required! }.to_not raise_error
end

def fails val
  expect { does_not_fail(val) }.to raise_error
end

describe Required do
  it { does_not_fail "moo" }
  it { does_not_fail 2 }
  it { does_not_fail 0 }

  it { fails nil }
  it { fails "" }

  it "takes a block" do
    user = OpenStruct.new(moo: "mo", fish: "")
    expect do
      user.required! do |u|
        u.fish
      end
    end.to raise_error

    expect do
      user.required! do |u|
        u.moo
      end
    end.to_not raise_error
  end
end
