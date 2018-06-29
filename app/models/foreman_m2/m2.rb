module ForemanM2
	class M2 < ComputeResource

		def self.model_name
			ComputeResource.model_name
		end

		def capabilities
			[:build, :image]
		end

		def available_images
			proxy = ::ProxyAPI::M2.new(url: SmartProxy.with_features('M2').first.url)
			proxy.get_images(:project => "bmi_infra")
		end

	end
end
