# TODO: remove dependency
require 'active_support/core_ext/object/blank'

module ValRequired
  module Method
    def required!(val = (val_not_set = true; nil))
      if block_given?
        yield(RequiredHelper.new(self))
      elsif !val_not_set
        raise BlankError.new("argument is blank!") if val.blank?
        val
      else
        raise BlankError.new("object is blank") if self.blank?
        self
      end
    end
  end

  class RequiredHelper < Struct.new(:obj)
    def method_missing method, *args
      obj.send(method, *args).required!
    end
  end

  class BlankError < StandardError
  end
end

class Object
  include ValRequired::Method
end
