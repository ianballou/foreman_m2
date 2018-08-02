require 'net/http'
require 'uri'

module ForemanM2
  # Example: Plugin's HostsController inherits from Foreman's HostsController
  class HostsController < ::HostsController
    # change layout if needed
    # layout 'foreman_m2/layouts/new_layout'

    def new_action
      # automatically renders view/foreman_m2/hosts/new_action

			proxy = ::ProxyAPI::M2.new(url: SmartProxy.with_features('M2').first.url)
			@response = proxy.get_images(:project => "ian")
			#@iscsi_target = proxy.get_iscsi_target(:project => "ian", :disk => "tester", :image => "dan_test_img")
			@snaps = proxy.get_snapshots(:project => "ian")
    end
  end
end
