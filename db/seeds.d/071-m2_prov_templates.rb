# Provisioning templates
pxelinux_kind = TemplateKind.unscoped.where(:name => 'PXELinux').first_or_create
ipxe_kind = TemplateKind.unscoped.where(:name => 'iPXE').first_or_create
organizations = Organization.unscoped.all
locations = Location.unscoped.all
created = []

ProvisioningTemplate.without_auditing do
  contents_pxelinux = File.read(File.join(ForemanM2::Engine.root, 'app', 'views', 'unattended', 'provisioning_templates', 'PXELinux', 'm2_default_pxelinux.erb'))
  created << 'M2 default PXELinux' unless ProvisioningTemplate.find_by_name('M2 default PXELinux')
  temp_pxelinux = ProvisioningTemplate.unscoped.where(:name => 'M2 default PXELinux').first_or_create do |template|
    template.attributes = {
      :template_kind_id => pxelinux_kind.id,
      :snippet => false,
      :template => contents_pxelinux
    }
  end
  temp_pxelinux.attributes = {
    :template => contents_pxelinux,
    :default => true,
    :vendor => "Foreman M2"
  }
  temp_pxelinux.locked = true
  temp_pxelinux.save!(:validate => false) if temp_pxelinux.changes.present?

  contents_ipxe = File.read(File.join(ForemanM2::Engine.root, 'app', 'views', 'unattended', 'provisioning_templates', 'iPXE', 'm2_default_ipxe.erb'))
  created << 'M2 default iPXE' unless ProvisioningTemplate.find_by_name('M2 default iPXE')
  temp_ipxe = ProvisioningTemplate.unscoped.where(:name => 'M2 default iPXE').first_or_create do |template|
    template.attributes = {
      :template_kind_id => ipxe_kind.id,
      :snippet => false,
      :template => contents_ipxe
    }
  end
  temp_ipxe.attributes = {
    :template => contents_ipxe,
    :default => true,
    :vendor => "Foreman M2"
  }
  temp_ipxe.locked = true
  temp_ipxe.save!(:validate => false) if temp_ipxe.changes.present?

  ProvisioningTemplate.unscoped.where(:name => created, :default => true).each do |template|
    template.organizations = organizations if SETTINGS[:organizations_enabled]
    template.locations = locations if SETTINGS[:locations_enabled]
  end
end
