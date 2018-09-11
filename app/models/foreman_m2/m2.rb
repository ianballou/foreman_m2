module ForemanM2
  class M2 < ComputeResource
    def self.model_name
      ComputeResource.model_name
    end

    def capabilities
      %i[build image hybrid]
    end

    def available_images
      proxy = SmartProxy.find_by name: "proxy_m2"
      proxyAPI = ::ProxyAPI::M2.new(url: proxy.url)
      # proxy = ::ProxyAPI::M2.new(url: url)
      proxyAPI.get_images([])
    end

    def client
    end
  end
end
