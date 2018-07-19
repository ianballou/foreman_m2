module ForemanM2
  module ComputeResourceExtensions
    extend ActiveSupport::Concern

    attr_accessor :image_id

    included do
      # execute callbacks
    end

    # create or overwrite instance methods...
    def instance_method_name
    end

    def new_vm(attr = {})
      return self
    end
      
    module ClassMethods
      # create or overwrite class methods...
      def class_method_name
      end
    end
  end
end
