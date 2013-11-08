require 'active_support/core_ext/object/blank'

module Required
  def required! val=nil
    if block_given?
      yield(Dummy.new(self))
    elsif self.class == Object
      puts fail "argument is blank!" if val.blank?
    else
      puts fail "object is blank" if self.blank?
    end
    true
  end

  class Dummy < Struct.new(:obj)
    def method_missing method, *args
      obj.send(method, *args).required!
    end
  end
end

class Object
  include Required
end
