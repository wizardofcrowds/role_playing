module RolePlaying
  module Context
    def self.included(base)
      base.extend(ClassMethods)
    end
    module ClassMethods
      def const_missing(sym)
        sym
      end
      def role(name, parent=nil, &block)
        parent = parent || RolePlaying::Role
        klass = Class.new(parent, &block)
        define_method(name) do |object, &role_block|
          instance = klass.new(object)
          role_block.nil? ? instance : role_block.call(instance)
        end
        const_set name, klass
      end
    end
  end
end