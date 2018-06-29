module ProxyAPI
	class M2 < ProxyAPI::Resource
		def initialize(args)
			@url = args[:url] + "/m2"
			super args
		end

		def get_images(args)
			img_strings = parse(get("image_list?project=#{args[:project]}"))
			#rescue => e
			#raise ProxyException.new(url, e, N_("Unable to get M2 images. args: " + args.inspect))
			
			id = 0
			imgs = []
			img_strings.each do |img|
				id += 1
				imgs << Image.new(:id => id, :uuid => id, :name => img)
			end

			return imgs
		end

		def get_iscsi_target(args)
			get("iscsi_target?project=#{args[:project]}&image=#{args[:image]}").body
		end
	end
end
