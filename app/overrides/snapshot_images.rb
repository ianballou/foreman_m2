Deface::Override.new(:virtual_path => "images/_list",
                     :name => "add_snapshot",
                     :replace => 'erb[loud]:contains("action_buttons")',
                     :partial => 'overrides/image_management/snapshot')
