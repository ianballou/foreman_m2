Deface::Override.new(:virtual_path => 'common/os_selection/_operatingsystem',
                     :name => 'add_bm_div_p2',
                     :remove =>
                       'erb[loud]:contains("select_f"):contains(":ptable_id")')
Deface::Override.new(:virtual_path => 'common/os_selection/_operatingsystem',
                     :name => 'add_bm_div_p1',
                     :replace =>
                       'erb[loud]:contains("select_f"):contains(":medium_id")',
                     :partial => 'overrides/host_creation/add_bm_div')
Deface::Override.new(:virtual_path => 'hosts/provision_method/build/_form',
                     :name => 'add_bm_div_p1',
                     :replace =>
                       'erb[loud]:contains("textarea_f"):contains(":disk")',
                     :partial => 'overrides/host_creation/add_ptable_div')
