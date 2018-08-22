module ForemanM2
  module NicExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
      #before_destroy :destroy_disk, :if => compute_resource.type == "ForemanM2::M2"
      delegate :hybrid_build?, :to => :host
    end

    # create or overwrite instance methods...

    def compute?
      false
    end
		
    class ::Host::Managed::Jail < Safemode::Jail
      #allow :iscsi_target, :hybrid_build?, :image_name
    end

    module ClassMethods
      # create or overwrite class methods...
      def class_method_name
      end
    end
  end
end
