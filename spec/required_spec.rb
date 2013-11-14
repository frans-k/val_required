require 'spec_helper'

require 'ostruct'

describe ValRequired do
  describe ".set?" do
    def set? obj
      ValRequired.set?(obj)
    end

    def set! obj
      expect(set? obj).to be_true
    end

    def not_set! obj
      expect(set? obj).to be_false
    end

    it { set! "token" }
    it { set! 2 }
    it { set! 0 }
    it { set! false }
    it { set! true }
    it { set! [] }
    it { set!({}) }

    it { not_set! nil }
    it { not_set! "" }
    it { not_set! " " }
  end

  it "works with assignment" do
    expect("token".required!).to eq "token"
  end

  it "takes a block" do
    user = OpenStruct.new(email: "", name: "Arnold")

    expect { required!(user, &:email) }.to raise_error(ValRequired::BlankError, /email/)
    expect { required!(user, &:name) }.to_not raise_error
  end

  it "takes an assignment block (config style)" do
    config = OpenStruct.new
    required!(config) {|config| config.service_token = "token" }

    expect(config.service_token).to eq "token"

    expect do
      required!(config) {|c| c.service_token = "" }
    end.to raise_error(ValRequired::BlankError, /service_token=/)
  end
end
