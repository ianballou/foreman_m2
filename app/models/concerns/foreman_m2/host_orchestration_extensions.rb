module ForemanM2
  module HostOrchestrationExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
    end

    # create or overwrite instance methods...

    def ssh_provision?
      compute_attributes.present? && (hybrid_build? || image_build?) && 
                                     !image.try(:user_data)
    end

    def validate_compute_provisioning
      return true if compute_attributes.nil?

      if hybrid_build?
        img = find_image
        if img
          self.image = img
        else
          failure(_('Selected image does not belong to %s') % compute_resource)
          return false
        end
      elsif image_build?
        return true if (compute_attributes[:image_id] || 
                        compute_attributes[:image_ref]).blank?

        img = find_image
        if img
          self.image = img
        else
          failure(_('Selected image does not belong to %s') % compute_resource)
          return false
        end
      else
        # don't send the image information to the compute resource 
        # unless using the image provisioning method
        %i[image_id image_ref].each do |image_key| 
          compute_attributes.delete(image_key) 
        end
      end
    end

    module ClassMethods
      # create or overwrite class methods...
      def class_method_name; end
    end
  end
end
