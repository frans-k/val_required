require 'spec_helper'

require 'ostruct'

def does_not_fail val
  expect { required! val }.to_not raise_error
  expect { val.required! }.to_not raise_error
end

def fails val
  expect { does_not_fail(val) }.to raise_error
end

describe ValRequired do
  it { does_not_fail "moo" }
  it { does_not_fail 2 }
  it { does_not_fail 0 }

  it { fails nil }
  it { fails "" }

  it "takes a block" do
    user = OpenStruct.new(moo: "mo", fish: "")
    expect { user.required!(&:fish) }.to raise_error

    expect { user.required!(&:moo) }.to_not raise_error
  end
end
