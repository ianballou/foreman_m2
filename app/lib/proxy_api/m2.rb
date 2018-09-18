module ProxyAPI
  class M2 < ProxyAPI::Resource
    def initialize(args)
      @url = args[:url] + '/m2'
      super args
    end

    def get_images(_args)
      # img_strings = parse(get("image_list?project=#{args[:project]}"))
      img_strings = parse(get('image_list'))

      id = 0
      imgs = []
      img_strings.each do |img|
        id += 1
        imgs << Image.new(:id => id, :uuid => id, :name => img)
      end

      imgs
    end

    def get_iscsi_target(args)
      get("iscsi_target?disk=#{args[:disk]}&image=#{args[:image]}").body
    end

    def delete_iscsi_target(args)
      delete("iscsi_target?disk=#{args[:disk]}").body
    end

    def get_snapshots(_args)
      # snap_strings = parse(get("snapshot_list?project=#{args[:project]}"))
      parse(get('snapshot_list'))
    end
  end
end
