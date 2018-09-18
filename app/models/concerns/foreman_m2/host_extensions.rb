module ForemanM2
  module HostExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
      # TODO: Destroy disk only if M2
      #before_destroy :destroy_disk #, prepend: true
      validates :root_pass, :length => { :minimum => 8, :message =>
                                         _('should be 8 characters or more') },
                            :presence => { :message =>
                                           N_('should not be blank - ' \
                                           'consider setting a global or ' \
                                           'host group default') },
                            :if => proc { |host| 
                                     host.managed && 
                                          (host.pxe_build? || 
                                           host.hybrid_build?) && build?
                                   }                                   
    end

    # create or overwrite instance methods...
    def instance_method_name; end

    def compute?
      false
    end

    class ::Host::Managed::Jail < Safemode::Jail
      allow :iscsi_target, :hybrid_build?, :image_name
    end

    def can_be_built?
      managed? && SETTINGS[:unattended] && (pxe_build? || hybrid_build?) && 
        !build?
    end

    def inherited_attributes
      inherited_attrs = %w[domain_id]
      if SETTINGS[:unattended]
        inherited_attrs.concat(
          %w[operatingsystem_id architecture_id compute_resource_id]
        )
        inherited_attrs << 'subnet_id' unless compute_provides?(:ip)
        inherited_attrs << 'subnet6_id' unless compute_provides?(:ip6)
        inherited_attrs.concat(%w[medium_id ptable_id pxe_loader]) \
          if pxe_build? || hybrid_build?
      end
      inherited_attrs
    end

    def hybrid_build?
      provision_method == 'hybrid'
    end

    def ensure_associations
      status = true
      if SETTINGS[:unattended] && managed? && os && 
        (pxe_build? || hybrid_build?)
        %w[ptable medium architecture].each do |e|
          value = send(e.to_sym)
          next if value.blank?

          unless os.send(e.pluralize.to_sym).include?(value)
            errors.add("#{e}_id".to_sym,
                       format(_('%{value} does not belong to %{os} '\
                       'operating system'),
                              :value => value, :os => os))
            status = false
          end
        end
      end

      if environment
        puppetclasses.select('puppetclasses.id,puppetclasses.name')
                     .distinct.each do |e|
          unless environment.puppetclasses.map(&:id).include?(e.id)
            errors.add(:puppetclasses,
                       format(_('%{e} does not belong to the '\
                       '%{environment} environment'),
                              :e => e, :environment => environment))
            status = false
          end
        end
      end
      status
    end

    def iscsi_target
      logger.info "Creating disk #{name}"
      proxy = SmartProxy.find_by name: 'proxy_m2'
      proxyAPI = ::ProxyAPI::M2.new(url: proxy.url)
      img = Image.find_by name: image_name
      # project = img.uuid
      proxyAPI.get_iscsi_target(:disk => name, :image => image_name)
    end

    def destroy_disk
      logger.info "Destroying disk #{name}"
      proxy = SmartProxy.find_by name: 'proxy_m2'
      proxyAPI = ::ProxyAPI::M2.new(url: proxy.url)
      proxyAPI.delete_iscsi_target(:disk => name)
    end

    module ClassMethods
      # create or overwrite class methods...
      def class_method_name; end
    end
  end
end
