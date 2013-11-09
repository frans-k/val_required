# TODO: remove dependency
require 'active_support/core_ext/object/blank'

module Required
  module Method
    def required! val=nil
      if block_given?
        yield(RequiredHelper.new(self))
      elsif self.class == Object
        raise BlankError.new("argument is blank!") if val.blank?
      else
        raise BlankError.new("object is blank") if self.blank?
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
  include Required::Method
end
