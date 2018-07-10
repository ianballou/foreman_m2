module ForemanM2
  module HostExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
    end

    # create or overwrite instance methods...
    def instance_method_name
    end
		
		class ::Host::Managed::Jail < Safemode::Jail
			allow :iscsi_target
		end

		def iscsi_target
			proxy = ::ProxyAPI::M2.new(url: SmartProxy.with_features('M2').first.url)
			proxy.get_iscsi_target(:project => "bmi_infra", :image => image_name)
		end

    module ClassMethods
      # create or overwrite class methods...
      def class_method_name
      end
    end
  end
end
