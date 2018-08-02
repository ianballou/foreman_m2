module ForemanM2
  module HostExtensions
    extend ActiveSupport::Concern


    included do
      # execute callbacks
      #before_destroy :destroy_disk, :if => compute_resource.type == "ForemanM2::M2"
      before_destroy :destroy_disk
    end

    # create or overwrite instance methods...
    def instance_method_name
    end

    def compute?
      false
    end
		
    class ::Host::Managed::Jail < Safemode::Jail
      allow :iscsi_target
    end

    def iscsi_target
      proxy = ::ProxyAPI::M2.new(url: SmartProxy.with_features('M2').first.url)
      img = Image.find_by name: image_name
      project = img.uuid
			proxy.get_iscsi_target(:project => project, :disk => name, :image => image_name)
    end

    def destroy_disk
      logger.info "Destroying disk #{name}"
			proxy = ::ProxyAPI::M2.new(url: SmartProxy.with_features('M2').first.url)
      proxy.delete_iscsi_target(:disk => name)
    end


    module ClassMethods
      # create or overwrite class methods...
      def class_method_name
      end
    end
  end
end
