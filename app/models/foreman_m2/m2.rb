module ForemanM2
	class M2 < ComputeResource

		def self.model_name
			ComputeResource.model_name
		end

		def capabilities
			[:build, :image, :hybrid]
		end

		def available_images
			proxy = ::ProxyAPI::M2.new(url: SmartProxy.with_features('M2').first.url)
			#proxy = ::ProxyAPI::M2.new(url: url)
			proxy.get_images([])
		end

		def client
			# XXX TOTAL SPOOF
			#@client = Fog::Compute.new(:provider => "Libvirt", :libvirt_uri => 'qemu:///system')
		end

	end
end
