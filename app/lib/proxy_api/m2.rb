module ProxyAPI
	class M2 < ProxyAPI::Resource
		def initialize(args)
			@url = args[:url] + "/m2"
			super args
		end

		def get_images(args)
			img_strings = parse(get("image_list", args))
			#rescue => e
			#raise ProxyException.new(url, e, N_("Unable to get M2 images. args: " + args.inspect))

			imgs = []
			img_strings.each do |img|
				imgs << Image.new(:name => img)
			end

			return imgs
		end
	end
end
