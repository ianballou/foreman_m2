module ForemanM2
  module NicExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
      #before_destroy :destroy_disk, :if => compute_resource.type == "ForemanM2::M2"
      delegate :hybrid_build?, :to => :host
    end

    # create or overwrite instance methods...
    
    module ClassMethods
      # create or overwrite class methods...
      def class_method_name
      end
    end
  end
end
