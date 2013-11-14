module ValRequired
  # Returns false unless non-empty String or other non-nil object.
  def self.set? obj
    if obj.instance_of? String
      !!(obj =~ /\S/)
    else
      !obj.nil?
    end
  end

  module Method
    def required!(val = (val_not_set = true; nil))
      if block_given?
        yield(RequiredHelper.new(self))
      elsif val_not_set
        raise BlankError.new("object is blank") unless ValRequired.set?(self)
        self
      else
        raise BlankError.new("argument is blank!") unless ValRequired.set?(val)
        val
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
