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
    def required!(context=nil)
      if block_given?
        yield(RequiredHelper.new(context.required!))
        self
      else
        raise BlankError.new("Object is not set: #{self.inspect}") unless ValRequired.set?(self)
        self
      end
    end
  end

  class RequiredHelper < Struct.new(:obj)
    def method_missing method, *args
      (res = obj.send(method, *args)).required!

    rescue BlankError
      raise BlankError, "#{method} returned #{res.inspect}"
    end
  end

  class BlankError < StandardError
  end
end

class Object
  include ValRequired::Method
end
