require 'spec_helper'

require 'ostruct'

def does_not_fail val
  expect { required! val }.to_not raise_error
  expect { val.required! }.to_not raise_error
end

def fails val
  expect { val.required! }.to raise_error(ValRequired::BlankError)
  expect { required!(val) }.to raise_error(ValRequired::BlankError)
end

describe ValRequired do
  it { does_not_fail "moo" }
  it { does_not_fail 2 }
  it { does_not_fail 0 }

  it { fails nil }
  it { fails "" }

  it "works with assignment" do
    m = "moo".required!
    expect(m).to eq "moo"

    expect { required!("") }.to raise_error

    m = required!("moo")
    expect(m).to eq "moo"
  end

  it "takes a block" do
    user = OpenStruct.new(moo: "mo", fish: "")

    expect { user.required!(&:fish) }.to raise_error
    expect { user.required!(&:moo) }.to_not raise_error
  end

  it "takes an assignment block (config style)" do
    config = OpenStruct.new
    required! do
      config.moo = "moo"
    end

    expect(config.moo).to eq "moo"

    expect do
      config.required! do |c|
        c.moo = ""
      end
    end.to raise_error
  end
end
